require 'rails_helper'

describe EmailedAccessRequest, type: :model do
  it "can be manually approved" do
    stub_request(:post, "https://www.example.com/api/admin/manual-access-request")
      .with(query: {
        requesterEmail: 'foo@bar.com',
        targetEmail: 'baz@qux.com',
        firstName: 'baz',
        lastName: 'qux'
      })
      .to_return(status: 200)

    result = EmailedAccessRequest.new(
      requester_email: 'foo@bar.com',
      target_email: 'baz@qux.com',
      first_name: 'baz',
      last_name: 'qux',
    ).manually_approve!

    expect(result).to eq("success")
  end
end
