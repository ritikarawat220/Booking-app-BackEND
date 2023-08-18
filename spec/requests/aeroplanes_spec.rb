require 'rails_helper'
require 'capybara/rspec'

RSpec.describe "Aeroplanes", type: :request do
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers # Include Warden test helpers
  Warden.test_mode! # Activate Warden test mode

  before do
    @user = User.create(name: 'lumbuye', email: 'text@t.com', password: '123456')
    login_as(@user) # Use Warden's login_as method to set up user authentication
    @aeroplane = @user.aeroplanes.build(name: 'jet', model: 'jet1', description:'bla', price: 12, booking_price:12, image: 'qwer')      
    @aeroplane1 = @user.aeroplanes.build(name: 'jet1', model: 'jet2', description:'blabla', price: 17, booking_price:190, image: 'qwert')      
    @aeroplane.save
    @aeroplane1.save
  end

  after do
    Warden.test_reset! # Reset Warden after each test
  end


  describe "GET /aeroplanes" do
    before do      
      get '/aeroplanes'     
    end

    it "Returns the http response sucess" do
      expect(response).to have_http_status(:success)
    end

    it 'Returns the render' do
      expect(response.content_type).to eq("application/json; charset=utf-8") 
    end     
      
    it 'Returns the body content' do
      aeroplane_response = JSON.parse(response.body)
      expect(aeroplane_response.length).to eq(2)
    end
  end

  describe 'GET /aeroplanes/:id' do
    before do
      get "/aeroplanes/#{@aeroplane.id}"
    end

    it 'Returns http response: success' do
      expect(response).to have_http_status(:success)
    end

    it 'Returns the render' do
      expect(response.content_type).to eq("application/json; charset=utf-8") 
    end   

    it 'Response body' do
      aeroplane_response = JSON.parse(response.body)
      expect(aeroplane_response['name']).to eq(@aeroplane.name)
    end

  end

  describe 'POST /aeroplanes' do
    before do
      @aeroplane_params = {
        aeroplane: {
          name: 'jet1',
          model: 'jet2',
          description:'blabla',
          price: 17,
          booking_price:190,
          image: 'qwert'    
        }
      }

      post '/aeroplanes/create', params: @aeroplane_params
    end

    it 'Creates a new aeroplane' do     
      expect(response).to have_http_status(:created)
    end

      it 'Returns the render' do
        expect(response.content_type).to eq("application/json; charset=utf-8") 
      end 

      it 'response for name' do
        aeroplane_response = JSON.parse(response.body)
        expect(aeroplane_response['name']).to eq(@aeroplane_params[:aeroplane][:name])
      end
  end

  describe 'delete' do
    it 'returns not found' do
      delete '/aeroplanes/34567'
      expect(response).to have_http_status(:not_found)
    end
  end
  
end
