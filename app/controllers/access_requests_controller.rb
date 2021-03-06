class AccessRequestsController < ApplicationController
  def index
    @access_requests = AccessRequestAPI.includes("requester")
  end

  def approve
    id = params[:id]

    begin
      access_request = AccessRequestAPI.new(id: id)
      access_request.approve
      flash[:notice] = "Successfully approved request"
      redirect_to action: 'inform_publisher', id: id
    rescue StandardError => e
      Raven.capture(e)
      set_flash_on_error_given(e)
      redirect_to action: 'index'
    end
  end

  def inform_publisher
    @recipient_email_address = AccessRequestAPI.find(params[:id]).first.recipient.email
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
      build_access_request
      @access_request.approve
      flash[:notice] = "Successfully approved request"
      @recipient_email_address = @emailed_access_request.target_email
      render 'inform_publisher'
    rescue StandardError => e
      Raven.capture(e)
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

  def build_access_request
    access_request_params = emailed_access_request_params.to_h
    access_request_params[:email_address] = access_request_params.delete(:target_email)
    access_request_params[:reason] = 'manual creation by user support agent'
    access_request_params[:organisation] = Userdb.find_by!(email: params["emailed_access_request"]['requester_email']).organisations
    @access_request = AccessRequestAPI.new(access_request_params)
    @access_request.save
  end
end
