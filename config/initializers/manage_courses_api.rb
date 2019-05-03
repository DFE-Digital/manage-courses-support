# frozen_string_literal: true

api_base_url = ENV['MANAGE_API_BASE_URL'] || 'https://www.example.com'
api_key = ENV['MANAGE_API_KEY'] || '12345'

MANAGE_COURSES_API = ManageCoursesAPI.new(api_base_url, api_key)
