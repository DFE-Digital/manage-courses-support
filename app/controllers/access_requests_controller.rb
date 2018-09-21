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
    @requester_email = params[:requester_email] || ''
    @target_email = params[:target_email] || ''
    @first_name = params[:first_name] || ''
    @last_name = params[:last_name] || ''
  end

  def preview
    @requester_email = params[:requester_email] || ''
    @target_email = params[:target_email] || ''
    @first_name = params[:first_name] || ''
    @last_name = params[:last_name] || ''
  end

  def submit
    keys = %i{requester_email target_email first_name last_name}
    data = keys.map { |key| [key, params[key]] }.to_h
    api_result = AccessRequest.manually_approve!(data)

    flash[:notice] = api_result

    if api_result == 'success'
      redirect_to action: 'index'
    else
      redirect_to action: 'preview', params: data
    end
  end
end
