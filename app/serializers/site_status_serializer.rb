class SiteStatusSerializer < ActiveModel::Serializer
  attributes :campus_code, :name, :vac_status, :publish, :status, :course_open_date, :recruitment_cycle

  def campus_code
    object.site.code
  end

  def course_open_date
    # TODO applications_accepted_from should be a timestamp, not a string
    DateTime.parse(object.applications_accepted_from).iso8601 if object.applications_accepted_from
  end

  def name
    object.site.location_name
  end

  # TODO: make recruitment cycle dynamic
  def recruitment_cycle
    {
      "name" => "2019/20"
    }
  end
end
