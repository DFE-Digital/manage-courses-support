require 'rails_helper'

describe AccessRequest, type: :model do
  subject(:request) { FactoryBot.create(:access_request, requester_email: 'ab@example.com') }

  let!(:requester) { FactoryBot.create(:user, email: 'ab@example.com') }

  it "is associated with a requester user via email" do
    expect(request.requester).to eq(requester)
  end

  it "can be approved" do
    stub_request(:post, "https://www.example.com/api/admin/access-request?accessRequestId=#{request.id}").to_return(status: 200)
    result = request.approve!
    expect(result).to eq("success")
  end

  it "can be manually approved" do
    stub_request(:post, "https://www.example.com/api/admin/manual-access-request")
      .with(query: {
        requesterEmail: 'foo@bar.com',
        targetEmail: 'baz@qux.com',
        firstName: 'baz',
        lastName: 'qux'
      })
      .to_return(status: 200)
    result = AccessRequest.manually_approve!(
      requester_email: 'foo@bar.com',
      target_email: 'baz@qux.com',
      first_name: 'baz',
      last_name: 'qux'
    )
    expect(result).to eq("success")
  end
end
