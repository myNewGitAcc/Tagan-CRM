require 'rails_helper'

RSpec.describe "Users", :type => :request do
  it "get user data" do
    user = create(:user)
    get "http://localhost:3000/api/v1/users/#{user.id}.json"
    expect(response.status).to eq(200)
  end
end