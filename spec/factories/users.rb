FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "user#{ i }@user.com" }
    password '12345678'
    password_confirmation { |user| user.password }
  end
end