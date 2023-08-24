require 'rails_helper'

RSpec.describe Aeroplane, type: :model do
  before do
    @user = User.new(name: 'Masaka', email: 'masaka@g.com', password: '123456')
    @aeroplane = @user.aeroplanes.build(name: 'jet', model: 'jet1', description: 'bla', price: 12, booking_price: 12,
                                        image: 'qwer')
  end

  it 'Should be valid if all the items are filled' do
    expect(@aeroplane).to be_valid
  end

  describe 'Should be invalid if a value is missing' do
    it 'Should be invalid if a name is missing' do
      @aeroplane.name = ''
      expect(@aeroplane).not_to be_valid
      expect(@aeroplane.errors.messages[:name]).to include("can't be blank")
    end

    it 'Should be invalid if a name is missing' do
      @aeroplane.model = ''
      expect(@aeroplane).not_to be_valid
      expect(@aeroplane.errors.messages[:model]).to include("can't be blank")
    end

    it 'Should be invalid if a name is missing' do
      @aeroplane.description = ''
      expect(@aeroplane).not_to be_valid
      expect(@aeroplane.errors.messages[:description]).to include("can't be blank")
    end

    it 'Should be invalid if a name is missing' do
      @aeroplane.price = ''
      expect(@aeroplane).not_to be_valid
      expect(@aeroplane.errors.messages[:price]).to include("can't be blank")
    end

    it 'Should be invalid if a name is missing' do
      @aeroplane.booking_price = ''
      expect(@aeroplane).not_to be_valid
      expect(@aeroplane.errors.messages[:booking_price]).to include("can't be blank")
    end

    it 'Should be invalid if a name is missing' do
      @aeroplane.image = ''
      expect(@aeroplane).not_to be_valid
      expect(@aeroplane.errors.messages[:image]).to include("can't be blank")
    end
  end

  describe 'Associations' do
    it 'Has many users through reservations' do
      association = described_class.reflect_on_association(:users)
      expect(association.macro).to eq :has_many
      expect(association.options[:through]).to eq :reservations
    end

    it 'Has many reservations' do
      association = described_class.reflect_on_association(:reservations)
      expect(association.macro).to eq :has_many
    end
  end
end
