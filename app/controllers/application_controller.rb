class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate

private


  def authenticate
    authenticate_or_request_with_http_basic('Administration') do |email, password|
      if password == AUTHENTICATION[email]
        add_token_to_connection(email)
        true
      else
        false
      end
    end
  end

  def add_token_to_connection(email)
    payload = {
      email:           email,
      # sign_in_user_id: current_user_dfe_signin_id
    }
    token = JWT.encode(payload,
                       Settings.authentication.secret,
                       Settings.authentication.algorithm)

    Thread.current[:manage_courses_backend_token] = token
  end
end
