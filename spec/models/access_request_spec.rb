# frozen_string_literal: true

require 'rails_helper'

describe AccessRequest, type: :model do
  subject(:request) { FactoryBot.create(:access_request, requester_email: 'ab@example.com') }

  let!(:requester) { FactoryBot.create(:user, email: 'ab@example.com') }

  it 'is associated with a requester user via email' do
    expect(request.requester).to eq(requester)
  end

  it 'can be approved' do
    network_request = stub_request(:post,
                                   "https://www.example.com/api/admin/access-request?accessRequestId=#{request.id}").to_return(status: 200)
    request.approve!
    expect(network_request).to have_been_made
  end
end
