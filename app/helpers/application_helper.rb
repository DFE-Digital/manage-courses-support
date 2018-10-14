module ApplicationHelper
  def count_of_unapproved_access_requests
    AccessRequest.unapproved.count
  end
end
