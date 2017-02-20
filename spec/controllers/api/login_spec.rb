require 'spec_helper'

RSpec.describe 'Login', :type => :request do
  let(:user) { FactoryGirl.create(:user) }
  it 'Check login' do
    post 'http://localhost:3000/api/v1/login.json', login: user.email, password: user.password
    expect(json['status']).to eq('success')
  end
end