class AccessRequestsController < ApplicationController
  def index
    @access_requests = AccessRequest.unapproved.order(request_date_utc: :asc)
  end

  def approve
    id = params[:id]
    api_result = AccessRequest.find(id).approve!

    if api_result == 'success'
      flash[:notice] = api_result
      flash[:access_request_id] = id
    else
      flash[:error] = api_result
      flash[:access_request_id] = id
    end

    redirect_to action: 'inform_publisher', id: id
  end

  def inform_publisher
    @recipient_email_address = AccessRequest.find(params[:id]).recipient.email
  end

  def new
    @emailed_access_request = EmailedAccessRequest.new(emailed_access_request_params)
  end

  def preview
    @emailed_access_request = EmailedAccessRequest.new(emailed_access_request_params)
  end

  def create
    @emailed_access_request = EmailedAccessRequest.new(emailed_access_request_params)
    api_result = @emailed_access_request.manually_approve!

    if api_result == 'success'
      flash[:notice] = api_result
      @recipient_email_address = @emailed_access_request.target_email
      render 'inform_publisher'
    else
      flash[:error] = api_result
      render 'preview'
    end
  end

private

  def emailed_access_request_params
    params.fetch(:emailed_access_request, {}).permit(:requester_email, :target_email, :first_name, :last_name)
  end
end
