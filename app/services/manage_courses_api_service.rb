require 'net/http'

class ManageCoursesAPIService
  def initialize(api_base_url, api_key)
    @api_base_url = api_base_url
    @api_key = api_key
  end

  # POST /api/admin/access-request
  def approve_access_request(id)
    uri = URI("#{@api_base_url}/api/admin/access-request?accessRequestId=#{id}")
    req = Net::HTTP::Post.new(uri)
    req['Accept'] = 'application/json'
    req['Authorization'] = "Bearer #{@api_key}"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(req)
    end

    result = case response.code
             when "200"
               "success"
             when "401"
               "unauthorized"
             when "404"
               "not-found"
             else
               "unknown-error"
             end

    result
  end
end
