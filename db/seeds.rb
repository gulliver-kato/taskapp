# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
    id: 1,
    name: 'admin',
    email: 'admin@testtest.com',
    password: '000000',
    password_confirmation: '000000',
    admin: 'true',
)
User.create!(
    id: 2,
    name: 'test1',
    email: 'test1l@test.com',
    password: '111111',
    password_confirmation: '111111',
)
Task.create!(
    name: '料理',
    content: 'ハンバーグ',
    end_date: '2020-05-10',
    priority: '高',
    status: '完了',
    user_id: 1,
)

Task.create!(
    name: '掃除',
    content: 'お風呂',
    end_date: '2020-04-30',
    priority: '高',
    status: '完了',
    user_id: 2,
)