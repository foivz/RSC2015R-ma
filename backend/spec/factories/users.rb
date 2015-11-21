require 'faker'

FactoryGirl.define do
  factory :user do
    name                   { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
    username               { Faker::Internet.user_name }
    password               '1234'
    password_confirmation  { password }
    access_token           { SecureRandom.uuid }
    self.role              { [:player, :judge].sample(1).first }
    active                 { [true, false].sample(1).first }
  end
end
