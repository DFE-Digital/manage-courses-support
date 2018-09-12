class OrganisationsEngagementReport
  QUERY = "
  WITH orgs_with_allocations AS (
      SELECT
          DISTINCT org_id
      FROM
          nctl_organisation
  )
  SELECT
      SUM(CASE WHEN oa.org_id IS NOT NULL THEN 1 ELSE 0 end) AS orgs_with_allocations
  FROM
      orgs_with_allocations oa".freeze

  def run
    @results = ActiveRecord::Base.connection.execute(QUERY)[0]
  end

  def [](key)
    @results[key.to_s]
  end
end
