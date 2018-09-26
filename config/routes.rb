Rails.application.routes.draw do
  root to: redirect('/organisations-engagement-report')

  get '/access-requests', to: 'access_requests#index'
  get '/organisations', to: 'organisations#index'
  get '/organisations/without-active-users', to: 'organisations#index_without_active_users'
  get '/organisations-engagement-report', to: 'reports#show_organisations_engagement_report', as: :organisations_engagement_report
  get '/access-requests/:id/approve', to: 'access_requests#approve!', as: :approve_access_request
  get '/access-requests/new', to: 'access_requests#new', as: :new_access_request
  get '/access-requests/preview', to: 'access_requests#preview', as: :preview_access_request
  post '/access-requests', to: 'access_requests#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
