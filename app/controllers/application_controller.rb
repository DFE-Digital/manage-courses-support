# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate

  private

  def authenticate
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      password == AUTHENTICATION[username]
    end
  end
end
