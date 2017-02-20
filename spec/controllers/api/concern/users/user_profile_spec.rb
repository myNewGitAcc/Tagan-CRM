require 'spec_helper'

RSpec.describe 'user profile', :type =>:request do
  let(:user) { FactoryGirl.create(:user) }
  it 'check user profile' do
    login_as(user)

    get "http://localhost:3000/api/v1/users/profile.json?access_token"
    expect(response.status).to eq(200)
  end
end