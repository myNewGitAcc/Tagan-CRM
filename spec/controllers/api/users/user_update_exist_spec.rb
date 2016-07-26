require 'rails_helper'

RSpec.describe "Users", :type => :request do
  it "update exist user" do

    FactoryGirl.create_list(:user, 10)

    i = 15
    user = User.find(i)
    user.email = 'ibra'
    put "http://localhost:3000/api/v1/users/#{user.id}.json"
    expect(user.email).to eq('ibra')
  end
end