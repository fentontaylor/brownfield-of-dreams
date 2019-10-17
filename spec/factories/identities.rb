# frozen_string_literal: true

FactoryBot.define do
  factory :identity do
    provider 'MyString'
    uid 1
    user nil
    user_name 'MyString'
    image_url 'MyString'
  end
end
