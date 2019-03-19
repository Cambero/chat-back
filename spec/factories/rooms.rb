# frozen_string_literal: true

FactoryBot.define do
  factory :room do
    sequence(:name) { |n| "Room #{n}" }
    owner  { 'AnyUser' }
  end

  trait :invalid do
    name { nil }
  end
end
