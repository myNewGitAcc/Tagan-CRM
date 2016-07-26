require 'rails_helper'

RSpec.describe "Articles", :type => :request do
  it "delete article" do
    user = create(:user)
    user0 = create(:user)
    user1 = create(:article, :user_id => '2')
    user2 = create(:article, :user_id => '1')
    user3 = create(:article, :user_id => '1')
    user4 = create(:article, :user_id => '2')
    id = 2
    delete "http://localhost:3000/api/v1/article/#{id}.json"
    expect(json['id']).to eq(id)

  end
end