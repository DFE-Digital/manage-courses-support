class ProviderSerializer < ActiveModel::Serializer
  attributes :institution_code

  def institution_code
    object.provider_code
  end
end
