require 'spec_helper'

RSpec.describe 'Update working time', :type => :request do
  let(:user) { FactoryGirl.create(:user)}
  let(:workingTime) {FactoryGirl.create(:WorkingTime)}

  it 'Should update Working times' do
    user.working_times << workingTime
    put "http://localhost:3000/api/v1/working_times/#{user.id}", created_at: user.created_at, :labor_hours => 1000
    expect(user.working_times.find_by(:id => workingTime.id).labor_hours).to eq(1000)
  end
end