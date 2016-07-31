FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "user#{ i }@example.com" }
    password 'password'
    password_confirmation { |user| user.password }
    date_of_birth '01.01.2001'
  end
end