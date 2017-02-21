require 'rails_helper'

RSpec.describe "Registration", :type => :request do
  it "sign up user" do

    post "http://localhost:3000/api/v1/register.json", email: 'vadim@test.com', password: '12345678'
    expect(json['message']).to eq('Your account is registered successfully')

  end
end