require 'spec_helper'

RSpec.describe 'Users', :type => :request do

  it 'check status' do
    get 'http://localhost:3000/api/v1/users/users.json'
    expect(response.status).to eq(200)
  end

  it 'check users' do
    FactoryGirl.create_list(:user, 7)

    get 'http://localhost:3000/api/v1/users/users.json'
    count = 0;
    json['data'].each do
      count += 1;
    end
    usersCount = User.all.count
    expect(usersCount).to eq(count)
  end

  it 'should return user data' do
    FactoryGirl.create(:user)
    user = User.first;
    get  "http://localhost:3000/api/v1/users/#{user.id}.json"
    expect(response.status).to eq(200)
  end

  it 'return 403 status if user nil' do
    get 'http://localhost:3000/api/v1/users/3.json'
    expect(response.status).to eq(403)
  end

end