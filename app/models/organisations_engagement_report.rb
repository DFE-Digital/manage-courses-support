class OrganisationsEngagementReport
  include ActionView::Helpers::NumberHelper

  QUERY = "
  WITH orgs_with_allocations AS (
      SELECT
          DISTINCT organisation_id
      FROM
          nctl_organisation
  ),
  orgs_with_ucas_courses AS (
      SELECT
          oi.organisation_id,
          count(DISTINCT c.course_code) number_of_courses
      FROM
          organisation_provider oi
          LEFT OUTER JOIN course c ON oi.provider_id = c.provider_id
      GROUP BY
          oi.organisation_id
  ),
  orgs_with_active_users AS (
      SELECT
          ou.organisation_id,
          sum(CASE WHEN u.welcome_email_date_utc IS NOT NULL THEN 1 ELSE 0 END) active_users
      FROM
          organisation_user ou
          JOIN \"user\" u ON ou.user_id = u.id
      WHERE u.email NOT LIKE '%education.gov.uk'
      GROUP BY ou.organisation_id
  ),
  orgs_with_inst_enrichments AS (
      SELECT
          oi.organisation_id,
          sum(CASE WHEN e.status = 1 THEN 1 ELSE 0 end) number_of_published_org_enrichments,
          sum(1) number_of_org_enrichments
      FROM
          provider_enrichment e
          JOIN provider i ON e.provider_code = i.provider_code
          JOIN organisation_provider oi ON oi.provider_id = i.id
      GROUP BY oi.organisation_id
  ),
  orgs_with_course_enrichments AS (
      SELECT
          oi.organisation_id,
          sum(CASE WHEN e.status = 1 THEN 1 ELSE 0 end) number_of_published_course_enrichments,
          sum(1) number_of_course_enrichments
      FROM
          course_enrichment e
          JOIN provider i ON e.provider_code = i.provider_code
          JOIN organisation_provider oi ON oi.provider_id = i.id
      GROUP BY oi.organisation_id
  )
  SELECT
      SUM(CASE WHEN oa.organisation_id IS NOT NULL THEN 1 ELSE 0 end) AS orgs_with_allocations,
      SUM(CASE WHEN ouc.number_of_courses > 0 THEN 1 ELSE 0 end) AS orgs_with_ucas_courses,
      SUM(CASE WHEN owu.active_users > 0 THEN 1 ELSE 0 end) AS orgs_with_active_users,
      SUM(CASE WHEN oie.number_of_org_enrichments > 0 THEN 1 ELSE 0 end) AS orgs_with_started_inst_enrichments,
      SUM(CASE WHEN oie.number_of_published_org_enrichments > 0 THEN 1 ELSE 0 end) AS orgs_with_published_inst_enrichments,
      SUM(CASE WHEN oce.number_of_course_enrichments > 0 THEN 1 ELSE 0 end) AS orgs_with_started_course_enrichments,
      SUM(CASE WHEN oce.number_of_published_course_enrichments > 0 THEN 1 ELSE 0 end) AS orgs_with_published_course_enrichments
  FROM
      orgs_with_allocations oa
      FULL OUTER JOIN orgs_with_ucas_courses ouc ON oa.organisation_id = ouc.organisation_id
      FULL OUTER JOIN orgs_with_active_users owu ON oa.organisation_id = owu.organisation_id
      FULL OUTER JOIN orgs_with_inst_enrichments oie ON oa.organisation_id = oie.organisation_id
      FULL OUTER JOIN orgs_with_course_enrichments oce ON oa.organisation_id = oce.organisation_id".freeze

  def run
    @results = ActiveRecord::Base.connection.execute(QUERY)[0]
  end

  def [](key)
    @results[key.to_s]
  end

  def percentage_of(key)
    ((self[key].to_f * 100) / self[:orgs_with_allocations]).to_i
  end
end
