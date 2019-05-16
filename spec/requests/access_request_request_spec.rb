require 'rails_helper'

describe "Access Requests", type: :request do
  let(:credentials) { ActionController::HttpAuthentication::Basic.encode_credentials("super.admin@education.gov.uk", "beta") }
  let(:auth_header) { { 'HTTP_AUTHORIZATION' => credentials } }


  describe 'GET #index' do
    it 'gets to backend index endpoint' do
      index_mock = stub_api_v2_request "/access_requests?include=requester", nil, :get
      get '/access-requests', headers: auth_header
      assert_requested index_mock
    end
  end

  describe 'POST #approve' do
    it 'posts to backend approve endpoint' do
      approve_mock = stub_api_v2_request "/access_requests/1/approve", nil, :post
      post '/access-requests/1/approve', headers: auth_header
      expect(response).to redirect_to action: :inform_publisher
      assert_requested approve_mock
    end
  end
end
