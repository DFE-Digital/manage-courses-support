class AccessRequestAPI < Base
  def self.table_name
    "access_requests"
  end

  def recipient
    User.new(first_name: first_name, last_name: last_name, email: requester_email)
  end

  custom_endpoint :approve, on: :member, request_method: :post
end
