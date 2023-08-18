require 'rails_helper'

RSpec.describe Reservation, type: :model do
  before do
    @user = User.create(name: 'Masaka', email: 'masaka@g.com', password: '123456')
    @aeroplane = Aeroplane.create(name: 'jet', model: 'jet1', description: 'bla', price: 12, booking_price: 12,
                                  image: 'qwer')
    @reservation = Reservation.new(reservation_date: '2020/01/01', returning_date: '2021/11/11', city: 'kampala',
                                   user: @user, aeroplane: @aeroplane)
  end

  it 'Should be valid if all values are input' do
    expect(@reservation).to be_valid
  end

  describe 'Should be invalid if a value is missing' do
    it 'Should be valid if all values are input' do
      @reservation.reservation_date = ''
      expect(@reservation).not_to be_valid
    end

    it 'Should be valid if all values are input' do
      @reservation.returning_date = ''
      expect(@reservation).not_to be_valid
    end

    it 'Should be valid if all values are input' do
      @reservation.city = ''
      expect(@reservation).not_to be_valid
    end
  end

  describe 'Associations' do
    it 'Belongs to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'Belongs to aeroplane' do
      association = described_class.reflect_on_association(:aeroplane)
      expect(association.macro).to eq :belongs_to
    end
  end
end
