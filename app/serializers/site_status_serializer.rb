class SiteStatusSerializer < ActiveModel::Serializer
  attributes :campus_code, :vac_status, :publish, :status

  def campus_code
    object.site.code
  end
end
