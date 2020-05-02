# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'test1' }
    email { 'test1@example.com' }
    password { '111111' }
    admin { false }
  end
  factory :admin_user, class: User do
    name { 'admin' }
    email { 'admin@example.com' }
    password { '000000' }
    admin { true }
  end
end
