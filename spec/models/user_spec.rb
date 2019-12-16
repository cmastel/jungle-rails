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
        password_confirmation: nil)
      expect(@user).to_not be_valid
    end

    it 'is not valid with confirmation does not match passworkd' do
      @user = User.create(
        name: 'Test User',
        email: 'user@email.com',
        password: 'password',
        password_confirmation: '123456')
      expect(@user).to_not be_valid
    end

    it 'is not valid without a name' do 
      @user = User.create(
        name: nil,
        email: 'user@email.com',
        password: 'password',
        password_confirmation: 'password')
      expect(@user).to_not be_valid
    end

    it 'is not valid without an email' do
      @user = User.create(
        name: 'Test User',
        email: nil,
        password: 'password',
        password_confirmation: 'password')
      expect(@user).to_not be_valid
    end

    it 'is not valid if email already exists (case insensitive)' do
      @user1 = User.new(
        name: 'Test User',
        email: 'user@email.COM'.downcase,
        password: 'password',
        password_confirmation: 'password')
      @user1.save!

      @user2 = User.create(
        name: 'Test User',
        email: 'USER@email.com'.downcase,
        password: 'password',
        password_confirmation: 'password')

      expect(@user2).to_not be_valid
    end

  end
end


