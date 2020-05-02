FactoryBot.define do
  factory :user do
    name { 'test1' }
    email { 'test1@hotmail.com' }
    password { '111111'}
    admin { false }    
  end
  factory :admin_user, class: User do
    name { 'admin' }
    email { 'admin@hotmail.com' }
    password { '000000' }
    admin { true }
  end
end
