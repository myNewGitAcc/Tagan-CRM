require 'rails_helper'

RSpec.describe "Articles", :type => :request do
  it "update article" do
    user = create(:user)
    user0 = create(:user)
    user1 = create(:article, :user_id => '2')
    user2 = create(:article, :user_id => '1')
    user3 = create(:article, :user_id => '1')
    user4 = create(:article, :user_id => '2')
    id = 4
    article = Article.find(id)
    article.subject = 'ibra'
    put "http://localhost:3000/api/v1/users/#{id}.json"
    expect(article.subject).to eq('ibra')

  end
end