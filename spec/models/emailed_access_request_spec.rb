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

  it "strips whitespace from attributes" do
    request = EmailedAccessRequest.new(
      requester_email: '  foo@bar.com  ',
      target_email: ' baz@qux.com ',
      first_name: '   baz   ',
      last_name: '   qux   ',
    )

    expect(request.requester_email).to eq('foo@bar.com')
    expect(request.target_email).to eq('baz@qux.com')
    expect(request.first_name).to eq('baz')
    expect(request.last_name).to eq('qux')
  end
end
