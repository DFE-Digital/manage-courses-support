class SiteStatusSerializer < ActiveModel::Serializer
  attributes :campus_code, :name, :vac_status, :publish, :status, :course_open_date

  def campus_code
    object.site.code
  end

  def course_open_date
    object.applications_accepted_from
  end

  def name
    object.site.location_name
  end
end
