# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "User #{n}" }
    rooms nil
    password_digest BCrypt::Password.create('secret').to_s
  end
end
