Rails.application.routes.draw do
  get '/access-requests' => 'access_requests#index'
  get '/organisations' => 'organisations#index'
  get '/' => 'reports#show_organisations_engagement_report'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
