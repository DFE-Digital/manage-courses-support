class SiteStatusSerializer < ActiveModel::Serializer
  attributes :campus_code

  def campus_code
    object.site.code
  end
end
