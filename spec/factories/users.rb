FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "User #{n}" }
    password_digest BCrypt::Password.create("secret").to_s
  end
end
