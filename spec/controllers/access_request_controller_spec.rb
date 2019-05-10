require 'rails_helper'

describe AccessRequestsController, type: :controller do
  describe 'POST #approve' do
    before do
      login
    end

    let(:params) { { id: 1 } }
    it 'succeeds' do
      stub_api_v2_request "/access_requests/1/approve", nil, :post
      post :approve, params: params
      expect(response).to redirect_to action: :inform_publisher
    end
  end
end
