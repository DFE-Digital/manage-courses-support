require 'rails_helper'

describe EmailedAccessRequest, type: :model do
  let(:emailed_request) {
    EmailedAccessRequest.new(
      requester_email: 'foo@bar.com',
      target_email: 'baz@qux.com',
      first_name: 'baz',
      last_name: 'qux',
    )
  }

  it "validates that requester and recipient fields are set" do
    request = EmailedAccessRequest.new

    expect(request).not_to be_valid
    expect(request.errors[:requester_email]).to eq([
      "Enter the email of someone already in the system"
    ])
    expect(request.errors[:target_email]).to eq([
      "Enter the email of the person who needs access"
    ])
    expect(request.errors[:first_name]).to eq([
      "Enter the first name of the person who needs access"
    ])
    expect(request.errors[:last_name]).to eq([
      "Enter the last name of the person who needs access"
    ])
  end

  it "validates that the requester exists" do
    request = EmailedAccessRequest.new(
      requester_email: 'nonexistent@email.com',
      target_email: 'baz@qux.com',
      first_name: 'baz',
      last_name: 'qux',
    )

    expect(request).not_to be_valid
    expect(request.errors[:requester_email]).to eq([
      "Enter the email of somebody already in the system"
    ])
  end

  it "can be manually approved" do
    FactoryBot.create(:user, email: 'foo@bar.com')
    request = stub_request(:post, "https://www.example.com/api/admin/manual-access-request")
      .with(query: {
        requesterEmail: 'foo@bar.com',
        targetEmail: 'baz@qux.com',
        firstName: 'baz',
        lastName: 'qux'
      })
      .to_return(status: 200)

    emailed_request.manually_approve!

    expect(request).to have_been_made
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

  it "instantiates a new recipient if they aren't a user in the system" do
    expect(emailed_request.recipient.attributes.slice("email", "first_name", "last_name")).to eq(
      "email" => 'baz@qux.com',
      "first_name" => 'baz',
      "last_name" => 'qux',
    )
    expect(emailed_request.recipient).not_to be_persisted
  end

  it "fetches the existing recipient if they are already a user in the system" do
    FactoryBot.create(:user,
      email: 'baz@qux.com', first_name: 'baz', last_name: 'qux')

    expect(emailed_request.recipient).to be_persisted
  end

  it "calculates which new organisations will be accessible after the request is actioned" do
    org_a, org_b, org_c = FactoryBot.create_list(:organisation, 3)

    FactoryBot.create(:user, email: 'foo@bar.com', organisations: [org_a, org_c])
    FactoryBot.create(:user, email: 'baz@qux.com', organisations: [org_a, org_b])

    expect(emailed_request.new_organisations_granted).to eq([org_c])
  end
end
