# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
require 'factory_girl_rails'

# Users
# (1..10).each do
#   FactoryGirl.create(:user)
# end
#
# FactoryGirl.create(:user, name: 'Dinko Osrecki', username: 'dinko', password: '1234', role: :player)
# FactoryGirl.create(:user, name: 'Gabrijel Mrgan', username: 'gabrijel', password: '1234', role: :player)

# Fields
FactoryGirl.create(:field)
FactoryGirl.create(:field, name: 'Field 2', latitude_nw: '46.308563', longitude_nw: '16.337690', latitude_se: '46.307804', longitude_se: '16.338085')
