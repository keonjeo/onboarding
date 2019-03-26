class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :first_name, type: String
  field :last_name, type: String
  field :age, type: Integer
  field :gender, type: String
  field :address, type: Hash, default: { country: nil, adrress_1: nil, adrress_2: nil }

  validates_presence_of :first_name, :last_name
  validates_numericality_of :age, greater_than: 0, only_integer: true
  validates :gender, inclusion: { in: %w(male female others) }

end
