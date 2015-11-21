# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
require 'factory_girl_rails'

(1..10).each do
  FactoryGirl.create(:user)
end
