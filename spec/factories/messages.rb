# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    sequence(:content) { |n| "Message #{n}" }
    username { 'AnyUser' }

    trait :invalid do
      content { nil }
    end
  end
end
