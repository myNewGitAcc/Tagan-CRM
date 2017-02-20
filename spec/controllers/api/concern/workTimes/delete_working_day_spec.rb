require 'spec_helper'

RSpec.describe 'Delete working day', :type => :request do
  let(:user) { FactoryGirl.create(:user)}
  let(:workingTime) {FactoryGirl.create(:WorkingTime)}

  it 'should delete working day' do
    user.working_times << workingTime
    delete "http://localhost:3000/api/v1/working_times/#{workingTime.id}.json"
    expect(response.status).to eq(200)

    delete("http://localhost:3000/api/v1/working_times/#{workingTime.id}.json")
    expect(response.status).to eq(403)
  end

end