class SiteSerializer < ActiveModel::Serializer
  attributes :campus_code

  def campus_code
    object.code
  end
end
