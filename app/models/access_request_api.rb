class AccessRequestAPI < Base
  def self.table_name
    "access_requests"
  end

  custom_endpoint :approve, on: :member, request_method: :post
end
