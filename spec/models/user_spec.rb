require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User Validation' do
    
    it 'is valid with valid attributes' do
      @user = User.new(
        name: 'Test User',
        email: 'user@email.com',
        password: 'password',
        password_confirmation: 'password')
      @user.save!
      expect(@user).to be_valid
    end

    it 'is not valid without a password' do 
      @user = User.create(
        name: 'Test User',
        email: 'user@email.com',
        password: nil,
        password_confirmation: 'password')
      expect(@user).to_not be_valid
    end

    it 'is not valid without a password confirmation' do 
      @user = User.create(
        name: 'Test User',
        email: 'user@email.com',
        password: 'password',
        password_confirmation: 'nil')
      expect(@user).to_not be_valid
    end


  end
end


