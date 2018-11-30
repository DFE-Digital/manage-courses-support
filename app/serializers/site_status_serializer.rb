class SiteStatusSerializer < ActiveModel::Serializer
  attributes :campus_code, :vac_status, :publish, :status, :course_open_date

  def campus_code
    object.site.code
  end

  def course_open_date
    object.applications_accepted_from
  end
end
