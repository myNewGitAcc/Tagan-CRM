require 'spec_helper'

RSpec.describe 'Working Time', :type => :request do
 let(:user) { FactoryGirl.create(:user)}
  let(:workingTime) {FactoryGirl.create(:WorkingTime)}

  it 'Return all working time' do
    user.working_times <<  workingTime
    get "http://localhost:3000/api/v1/working_times/#{user.id}.json"
    expect(response.status).to eq(200)
  end

end