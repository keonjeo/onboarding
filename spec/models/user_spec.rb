RSpec.describe User, type: :model do

  context '#Validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_numericality_of(:age).to_allow(only_integer: true, greater_than: 0) }
    it do
      should validate_inclusion_of(:gender).to_allow('male', 'female', 'others')
    end
  end

  context '#Associations' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to have_timestamps }
    it { is_expected.to have_one(:shop) }
  end
end
