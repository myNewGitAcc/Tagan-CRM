require 'rails_helper'

RSpec.describe "Users", :type => :request do

  it "get all users" do

    FactoryGirl.create_list(:user, 3)

    get "http://localhost:3000/api/v1/users/users.json"
    count = 0
    json['data'].each {|c| count += 1 }
    counter = User.all.count
    expect(count).to eq(counter)

  end
end