# spec/support/mongoid_rspec.rb

RSpec.configure do |config|
  config.include Mongoid::Matchers, type: :model
end
