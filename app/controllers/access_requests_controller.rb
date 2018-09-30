class AccessRequestsController < ApplicationController
  def index
    @access_requests = AccessRequest.unapproved.order(request_date_utc: :asc)
  end

  def approve
    id = params[:id]
    api_result = AccessRequest.find(id).approve!

    if api_result == 'success'
      flash[:notice] = "Successfully approved request"
      redirect_to action: 'inform_publisher', id: id
    else
      set_flash_on_error_given(api_result)
      redirect_to action: 'index'
    end
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
      flash[:notice] = "Successfully approved request"
      @recipient_email_address = @emailed_access_request.target_email
      render 'inform_publisher'
    else
      set_flash_on_error_given(api_result)
      render 'preview'
    end
  end

private

  def set_flash_on_error_given(api_result)
    flash[:error_summary] = "Problem approving request"
    flash[:errors] = [{
      text: "A technical issue has occurred – #{explanation_of(api_result)}. Please let the technical support team know."
    }]
  end

  def explanation_of(api_result)
    case api_result
    when 'unauthorized'
      'API client is unauthorized'
    when 'not-found'
      'access request or the requester email not found'
    else
      "unexpected error (#{api_result}) from the API"
    end
  end

  def emailed_access_request_params
    params.fetch(:emailed_access_request, {}).permit(:requester_email, :target_email, :first_name, :last_name)
  end
end
