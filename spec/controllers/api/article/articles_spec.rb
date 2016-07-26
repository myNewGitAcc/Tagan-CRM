require 'rails_helper'

RSpec.describe "Articles", :type => :request do

  it "get all articles" do

    FactoryGirl.create_list(:article, 10)

    get "http://localhost:3000/api/v1/article.json"
    count = 0
    json['data'].each {|c| count += 1 }
    counter = Article.all.count
    expect(count).to eq(counter)
  end

end