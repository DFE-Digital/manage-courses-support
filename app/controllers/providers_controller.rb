class ProvidersController < ActionController::API
  def index
    @providers = Provider.all
    paginate json: @providers
  end
end
