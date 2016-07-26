require 'rails_helper'

RSpec.describe "Registration", :type => :request do
  it "register user" do

    post "http://localhost:3000/api/v1/register.json", email: 'umakhan@mail.ru', password: '445566'
    expect(json['message']).to eq('Your account is registered successfully')

  end
end