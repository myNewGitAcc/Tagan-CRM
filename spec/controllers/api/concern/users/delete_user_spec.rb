require 'spec_helper'

RSpec.describe 'Delete user', :type => :request do

  it 'Check delete nonexistent user' do
    delete 'http://localhost:3000/api/v1/users/5.json'
    expect(response.status).to eq(403)
  end

  it 'Check delete existed user' do
    FactoryGirl.create(:user)
    delete 'http://localhost:3000/api/v1/users/1.json'
    expect(response.status).to eq(200)

    delete 'http://localhost:3000/api/v1/users/1.json'
    expect(response.status).to eq(403)
  end

end