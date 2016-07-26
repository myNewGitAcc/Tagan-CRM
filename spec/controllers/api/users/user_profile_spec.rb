require 'rails_helper'

RSpec.describe "UserProfile", :type => :request do
  it "get status user_profille" do
    user = create(:user)
    login_as(user)
    get 'http://localhost:3000/api/v1/users/profile.json'
    expect(response.status).to eq(200)
    logout(user)
  end
end