require 'rails_helper'

RSpec.describe "Session", :type => :request do
  it "post sign in" do
    user = create(:user)

    post "http://localhost:3000/api/v1/login.json", login: user.email, password: user.password
    expect(json['data']['email']).to eq(user.email)
  end
end