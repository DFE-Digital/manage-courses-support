api_base_url = ENV['MANAGE_API_BASE_URL'] || 'https://www.example.com/api'
api_key = ENV['MANAGE_API_KEY'] || 'Bearer 12345'

MANAGE_COURSES_API_SERVICE = ManageCoursesAPIService.new(api_base_url, api_key)
