require 'faker'

FactoryGirl.define do
  factory :field do
    name                  { Faker::Name.name }
    latitude_nw           BigDecimal.new('46.307795')
    longitude_nw          BigDecimal.new('16.337911')
    latitude_se           BigDecimal.new('46.307243')
    longitude_se          BigDecimal.new('16.338671')
    occupied              false
  end
end
