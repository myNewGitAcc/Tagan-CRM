require 'spec_helper'

RSpec.describe "users Update", :type => :request do

  it "Update users_data" do
    FactoryGirl.create(:user)
    newUserEmail =  'newmail@new.com'
    user = User.first
    user.email = newUserEmail
    put "http://localhost:3000/api/v1/users/#{user.id}.json"
    expect(user.email).to eq(newUserEmail)
  end
end