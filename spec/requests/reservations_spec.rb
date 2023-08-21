require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Aeroplanes', type: :request do
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    @user = User.create(name: 'lumbuye', email: 'text@t.com', password: '123456', password_confirmation: '123456')
    login_as(@user)
    @aeroplane = Aeroplane.create(name: 'jet', model: 'jet1', description: 'bla', price: 12, booking_price: 12,
                                        image: 'qwer')

    @reservation = Reservation.create(reservation_date: '2020/01/01', returning_date: '2021/11/11', city: 'kampala', user: @user, aeroplane: @aeroplane)
  end

  after do
    Warden.test_reset!
  end
  describe 'GET /aeroplanes/#{aeroplanes.id}/reservations' do
    before do
      get "/aeroplanes/#{@aeroplane.id}/reservations"
    end

    it 'Should return http response: success' do
      expect(response).to have_http_status(:success)
    end

    it 'Returns the response content type' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'Should return the body response' do
      reservation_response = JSON.parse(response.body)
      expect(reservation_response.length).to eq(1)
      expect(reservation_response).to be_an(Array)
      expect(reservation_response[0]['city']).to eq(@reservation.city.to_s)
    end    
  end

  describe 'GET /aeroplanes/#{aeroplanes.id}/reservations/#{reservations.id}' do
    before do
      get "/aeroplanes/#{@aeroplane.id}/reservations/#{@reservation.id}"
    end

    it 'Should return http response: success' do
      expect(response).to have_http_status(:success)
    end

    it 'Returns the response content type' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'Should return the body response' do
      reservation_response = JSON.parse(response.body)
      expect(reservation_response).to be_an(Hash)
      
    end
  end

  describe 'POST /aeroplanes/:id/reservations/create' do
    before do
      @reservation_params = {
        reservation: { reservation_date: '2020/01/01', 
        returning_date: '2021/11/11', 
        city: 'kampala', 
        user: @user, 
        aeroplane: @aeroplane
        }
      }

      post "/aeroplanes/#{@aeroplane.id}/reservations", params: @reservation_params
    end
    
    it 'Creates a new reservation' do
      expect(response).to have_http_status(:created)
    end

    it 'Returns the response content type' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'response for name' do
      reservation_response = JSON.parse(response.body)
      expect(reservation_response['city']).to eq(@reservation_params[:reservation][:city])
    end
  end

  describe 'delete' do
    it 'Deletes a selected item' do
      delete "/aeroplanes/#{@aeroplane.id}/reservations/#{@reservation.id}"
      expect(response).to have_http_status(:success)
    end
  end
  
end