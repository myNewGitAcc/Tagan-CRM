require 'rails_helper'

RSpec.describe "Articles", :type => :request do
  it "create article" do

    post "http://localhost:3000/api/v1/article.json", subject: 'umakhan@mail.ru', body: '445566'
    expect(response.status).to eq(201)

  end
end