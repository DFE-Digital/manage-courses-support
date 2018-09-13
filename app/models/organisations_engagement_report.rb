class OrganisationsEngagementReport
  QUERY = "
  WITH orgs_with_allocations AS (
      SELECT
          DISTINCT org_id
      FROM
          nctl_organisation
  ),
  orgs_with_ucas_courses AS (
      SELECT
          oi.org_id,
          count(DISTINCT c.crse_code) number_of_courses
      FROM
          mc_organisation_institution oi
          LEFT OUTER JOIN ucas_course c ON oi.institution_code = c.inst_code
      GROUP BY
          oi.org_id
  ),
  orgs_with_active_users AS (
      SELECT
          ou.org_id,
          sum(CASE WHEN u.welcome_email_date_utc IS NOT NULL THEN 1 ELSE 0 END) active_users
      FROM
          mc_organisation_user ou
          JOIN mc_user u ON ou.email = u.email
      WHERE u.email NOT LIKE '%education.gov.uk'
      GROUP BY ou.org_id
  )
  SELECT
      SUM(CASE WHEN oa.org_id IS NOT NULL THEN 1 ELSE 0 end) AS orgs_with_allocations,
      SUM(CASE WHEN ouc.number_of_courses > 0 THEN 1 ELSE 0 end) AS orgs_with_ucas_courses,
      SUM(CASE WHEN owu.active_users > 0 THEN 1 ELSE 0 end) AS orgs_with_active_users
  FROM
      orgs_with_allocations oa
      FULL OUTER JOIN orgs_with_ucas_courses ouc ON oa.org_id = ouc.org_id
      FULL OUTER JOIN orgs_with_active_users owu ON oa.org_id = owu.org_id".freeze

  def run
    @results = ActiveRecord::Base.connection.execute(QUERY)[0]
  end

  def [](key)
    @results[key.to_s]
  end
end
