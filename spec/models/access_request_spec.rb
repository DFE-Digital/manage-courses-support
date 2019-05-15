require 'rails_helper'

describe AccessRequest, type: :model do
  subject(:request) { FactoryBot.create(:access_request, requester: requester) }

  let!(:requester) { FactoryBot.create(:user, email: 'ab@example.com') }

  it "is associated with a requester user" do
    expect(request.requester).to eq(requester)
  end
end
