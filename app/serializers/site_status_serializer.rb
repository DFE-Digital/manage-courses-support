class SiteStatusSerializer < ActiveModel::Serializer
  attributes :campus_code, :vac_status, :publish

  def campus_code
    object.site.code
  end
end
