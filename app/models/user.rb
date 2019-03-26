class User < ActiveRecord::Base

  validates_presence_of :first_name, :last_name
  validates_numericality_of :age, greater_than: 0
  validates :gender, inclusion: { in: %w(male female others) }

end
