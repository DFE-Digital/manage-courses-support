require 'rails_helper'

describe User, type: :model do
  let!(:requester) { FactoryBot.create(:user, email: 'ab@example.com') }
  subject { FactoryBot.create(:access_request, requester_email: 'ab@example.com') }

  it "is associated with a requester user via email" do
    expect(subject.requester).to eq(requester)
  end
end
