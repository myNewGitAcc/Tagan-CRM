require 'rails_helper'

RSpec.describe "Session", :type => :request do
  it "logout status" do
    user = create(:user)
    login_as(user)
    delete "http://localhost:3000/api/v1/logout.json"
    expect(json['message']).to eq('You are logged out successfully')
  end
end