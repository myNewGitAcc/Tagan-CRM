require 'spec_helper'

RSpec.describe 'Logout', :type =>:request do
  let(:user) { FactoryGirl.create(:user) }
  it 'check logout' do
   login_as(user)

    delete "http://localhost:3000/api/v1/logout.json"
    expect(json['status']).to eq('success')
  end
end