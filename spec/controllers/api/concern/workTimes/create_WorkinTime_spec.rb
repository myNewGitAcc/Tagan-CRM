require 'spec_helper'

RSpec.describe 'Create Working Time', :type => :request do

  it 'Check working time creation' do
    FactoryGirl.create(:user)
    user = User.last
    post 'http://localhost:3000/api/v1/working_times', user_id: user.id, status_change_date: '2017-01-19 14:48:03',
        labor_hours: '5000'
    expect(json['status']).to eq('success')
  end

end