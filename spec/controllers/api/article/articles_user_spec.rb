require 'rails_helper'

RSpec.describe "Articles", :type => :request do
  it "get articles user " do
    FactoryGirl.create_list(:user, 5)
    create(:article, :user_id => '3')
    create(:article, :user_id => '4')
    create(:article, :user_id => '5')
    create(:article, :user_id => '3')
    create(:article, :user_id => '4')
    create(:article, :user_id => '5')
    create(:article, :user_id => '3')
    user_id = 4
    article = Article.where(user_id: user_id).count
    count = 0
    get "http://localhost:3000/api/v1/article/#{user_id}.json"
    json['data'].each {|c| count += 1 }
    expect(article).to eq(count)

  end
end