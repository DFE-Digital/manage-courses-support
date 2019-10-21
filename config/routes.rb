Rails.application.routes.draw do
  root to: redirect("/organisations")

  get "/organisations", to: "organisations#index"
  get "/organisations/without-active-users", to: "organisations#index_without_active_users"

  resources :access_requests, path: "/access-requests", only: %i{index new create} do
    post "approve", on: :member
    get "inform-publisher", on: :member
    get "preview", on: :collection
  end
end
