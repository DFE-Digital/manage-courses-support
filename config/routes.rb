Rails.application.routes.draw do
  get '/access-requests' => 'access_requests#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
