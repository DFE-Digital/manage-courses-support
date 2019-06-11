module ApplicationHelper
  def count_of_unapproved_access_requests
    AccessRequestAPI.all.count
  end
end
