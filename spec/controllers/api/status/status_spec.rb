require 'rails_helper'

RSpec.describe "Status", :type => :request do
  it "get status of the Base" do
    get "http://localhost:3000/api/v1/status.json"
    expect(json['status']).to eq('ok')
  end
end