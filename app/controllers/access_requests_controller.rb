class AccessRequestsController < ApplicationController
  def index
    @access_requests = AccessRequest.unapproved.order(request_date_utc: :asc)
  end

  def approve!
    id = params[:id]
    api_result = AccessRequest.find(id).approve!

    flash[:notice] = api_result
    flash[:access_request_id] = id

    redirect_to action: 'index'
  end

  def create
    @emailed_access_request = EmailedAccessRequest.new(emailed_access_request_params)
  end

  def preview
    @emailed_access_request = EmailedAccessRequest.new(emailed_access_request_params)
  end

  def submit
    @emailed_access_request = EmailedAccessRequest.new(emailed_access_request_params)
    api_result = @emailed_access_request.manually_approve!

    flash[:notice] = api_result

    if api_result == 'success'
      redirect_to action: 'index'
    else
      redirect_to action: 'preview', params: data
    end
  end

private

  def emailed_access_request_params
    params.fetch(:emailed_access_request, {}).permit(:requester_email, :target_email, :first_name, :last_name)
  end
end
