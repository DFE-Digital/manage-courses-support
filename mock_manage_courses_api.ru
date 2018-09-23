class ManageCoursesAPIStub
  def call(env)
    req = Rack::Request.new(env)
    case req.path_info
    when %r{/api/admin/(manual-)?access-request}
      [200, {"Content-Type" => "application/json"}, []]
    else
      [404, {"Content-Type" => "application/json"}, [""]]
    end
  end
end

run ManageCoursesAPIStub.new
