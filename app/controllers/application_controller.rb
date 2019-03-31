class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate
  before_action :bat_environment

private

  def authenticate
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      password == AUTHENTICATION[username]
    end
  end
end
