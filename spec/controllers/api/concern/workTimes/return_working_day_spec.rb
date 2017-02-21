require 'spec_helper'

RSpec.describe 'Working day', :type => :request do
  let(:user) { FactoryGirl.create(:user)}
  let(:workingTime) {FactoryGirl.create(:WorkingTime)}

  it 'Should return working day' do
    user.working_times << workingTime
    get 'http://localhost:3000/api/v1/working_times/', user_id: user.id, created_at: user.created_at
    expect(json['status']).to eq('success')
  end
end