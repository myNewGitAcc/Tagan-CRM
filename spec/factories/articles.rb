FactoryGirl.define do
  factory :article do
    sequence(:subject) { |i| "article#{ i }" }
    body 'body'
  end

end