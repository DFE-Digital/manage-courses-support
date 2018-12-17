class ProviderWithSitesSerializer < ProviderSerializer
  has_many :sites, key: :campuses
end
