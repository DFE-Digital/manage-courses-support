require 'net/http'

class ManageCoursesAPI
  def initialize(api_base_url, api_key)
    @api_base_url = api_base_url
    @api_key = api_key
  end

  # POST /api/admin/access-request
  def approve_access_request(id)
    uri = URI("#{@api_base_url}/api/admin/access-request?accessRequestId=#{id}")
    post_to(uri)
  end

  # POST /api/admin/manual-access-request
  def manually_approve_access_request(data)
    uri = URI("#{@api_base_url}/api/admin/manual-access-request")
    uri.query = URI.encode_www_form(
      requesterEmail: data[:requester_email],
      targetEmail: data[:target_email],
      firstName: data[:first_name],
      lastName: data[:last_name]
    )
    post_to(uri)
  end

private

  def post_to(uri)
    req = Net::HTTP::Post.new(uri)
    req['Accept'] = 'application/json'
    req['Authorization'] = "Bearer #{@api_key}"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(req)
    end

    parse_response_code(response.code)
  rescue Timeout::Error, Errno::EINVAL, Errno::ECONNREFUSED, Errno::ECONNRESET, EOFError,
         Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError
    'network-failure'
  end

  def parse_response_code(code)
    case code
    when '200'
      'success'
    when '401'
      'unauthorized'
    when '404'
      'not-found'
    else
      'unknown-error'
    end
  end
end
