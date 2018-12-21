Rails.application.routes.draw do
  root to: redirect('/organisations-engagement-report')

  get '/organisations', to: 'organisations#index'

  scope '/api/v1' do
    get '/courses', to: 'courses#index'
    get '/providers', to: 'providers#index'
    get '/subjects', to: 'subjects#index'
  end

  get '/organisations/without-active-users', to: 'organisations#index_without_active_users'
  get '/organisations-engagement-report', to: 'reports#show_organisations_engagement_report', as: :organisations_engagement_report

  resources :access_requests, path: '/access-requests', only: %i{index new create} do
    get 'approve', on: :member
    get 'inform-publisher', on: :member
    get 'preview', on: :collection
  end
end
