class AccessRequestsController < ApplicationController
  def index
    @access_requests = AccessRequest.unapproved.order(request_date_utc: :asc)
  end

  def approve!
    id = params[:id]
    api_result = AccessRequest.find(id).approve!

    flash[:notice] = api_result
    flash[:access_request_id] = id

    redirect_to action: "index"
  end
end
