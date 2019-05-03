class AccessRequestsController < ApplicationController
  def index
    @access_requests = AccessRequest.unapproved.order(request_date_utc: :asc)
  end

  def approve
    id = params[:id]

    begin
      AccessRequest.find(id).approve!
      flash[:notice] = "Successfully approved request"
      redirect_to action: 'inform_publisher', id: id
    rescue ManageCoursesAPI::AccessRequestInternalFailure => e
      set_flash_on_error_given(e)
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

    if @emailed_access_request.invalid?
      flash.now[:errors] = @emailed_access_request.errors.messages.values.flatten.map do |error|
        { "text" => error, "link" => '#emailed_access_request_requester_email' }
      end
      render action: 'new'
      return
    end
  end

  def create
    @emailed_access_request = EmailedAccessRequest.new(emailed_access_request_params)

    begin
      @emailed_access_request.manually_approve!
      flash[:notice] = "Successfully approved request"
      @recipient_email_address = @emailed_access_request.target_email
      render 'inform_publisher'
    rescue ManageCoursesAPI::AccessRequestInternalFailure => e
      set_flash_on_error_given(e)
      render 'preview'
    end
  end

private

  def set_flash_on_error_given(exception)
    flash[:error_summary] = "Problem approving request"
    flash[:errors] = [{
      "text" => "A technical issue has occurred - let the technical support team know: #{exception.message}"
    }]
  end

  def emailed_access_request_params
    params.fetch(:emailed_access_request, {}).permit(:requester_email, :target_email, :first_name, :last_name)
  end
end
