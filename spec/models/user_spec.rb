require 'rails_helper'

RSpec.describe User, type: :model do
  it 'Should be valid with all parameters' do
    @user = User.new(name: 'Mudassir', email: 'mudasir@g.com', password: '1234567', password_confirmation: '1234567')
    expect(@user).to be_valid
  end

  it 'Should be invalid with a missing parameter' do
    @user = User.new(name: '', email: '', password: '')
    expect(@user).not_to be_valid
    expect(@user.errors.messages[:name]).to include("can't be blank")
    expect(@user.errors.messages[:email]).to include("can't be blank")
    expect(@user.errors.messages[:password]).to include("can't be blank")
  end
end
