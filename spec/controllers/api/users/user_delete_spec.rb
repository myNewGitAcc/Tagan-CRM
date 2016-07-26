require 'rails_helper'

RSpec.describe "Users", :type => :request do
  it "delete user" do
    user = create(:user)
    delete "http://localhost:3000/api/v1/users/#{user.id}.json"
    expect(response.status).to eq(200)
  end
end