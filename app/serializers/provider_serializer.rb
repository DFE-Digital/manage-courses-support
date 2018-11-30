class ProviderSerializer < ActiveModel::Serializer
  attributes :institution_code, :institution_name

  def institution_code
    object.provider_code
  end

  def institution_name
    object.provider_name
  end
end
