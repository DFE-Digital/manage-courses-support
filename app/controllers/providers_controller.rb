class ProvidersController < ActionController::API
  def index
    @providers = Provider.all
    paginate json: @providers, each_serializer: ProviderWithSitesSerializer
  end
end
