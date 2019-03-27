# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :user do
    first_name       { 'Andy' }
    last_name        { 'Wang' }
    age              { 20 }
    gender           { 'male' }
    address          { { country: 'China', address_1: 'ShenZhen City', address_2: 'GuangZhou City' } }
  end
end
