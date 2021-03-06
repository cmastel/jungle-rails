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
        email: 'user@email.COM',
        password: 'password',
        password_confirmation: 'password')
      @user1.save!

      @user2 = User.create(
        name: 'Test User',
        email: 'USER@email.com',
        password: 'password',
        password_confirmation: 'password')

      expect(@user2).to_not be_valid
    end

    it 'is not valid with a password less than 4 characters' do
      @user = User.create(
        name: 'Test User',
        email: 'user@email.com',
        password: 'pass',
        password_confirmation: '123')
      expect(@user).to_not be_valid
    end

  end

  describe '.authenticate_with_credentials' do
    
    it 'is valid with valid attributes' do
      @user = User.new(
        name: 'Test User',
        email: 'user@email.com',
        password: 'password',
        password_confirmation: 'password')
      @user.save!

      login = @user.authenticate_with_credentials(@user.email, @user.password)
      expect(login).to be_truthy
    end

    it 'is not valid with an incorrect password' do 
      @user = User.new(
        name: 'Test User',
        email: 'user@email.com',
        password: 'password',
        password_confirmation: 'password')
      @user.save!

      login = @user.authenticate_with_credentials(@user.email, 'wrongpassword')
      expect(login).to_not be_truthy
    end

    it 'is not valid with a user that does not exist' do 
      @user = User.new(
        name: 'Test User',
        email: 'user@email.com',
        password: 'password',
        password_confirmation: 'password')
      @user.save!

      login = @user.authenticate_with_credentials('wronguser@email.com', @user.password)
      expect(login).to_not be_truthy
    end

    it 'is not valid with a user that does not exist' do 
      @user = User.new(
        name: 'Test User',
        email: 'user@email.com',
        password: 'password',
        password_confirmation: 'password')
      @user.save!

      login = @user.authenticate_with_credentials('wronguser@email.com', @user.password)
      expect(login).to_not be_truthy
    end

    it 'is valid with an email that has preceding spaces' do 
      @user = User.new(
        name: 'Test User',
        email: 'user@email.com',
        password: 'password',
        password_confirmation: 'password')
      @user.save!

      login = @user.authenticate_with_credentials('   user@email.com', @user.password)
      expect(login).to be_truthy
    end

    it 'is valid with an email that has non-matching case' do 
      @user = User.new(
        name: 'Test User',
        email: 'user@email.COM',
        password: 'password',
        password_confirmation: 'password')
      @user.save!

      login = @user.authenticate_with_credentials('USER@email.com', @user.password)
      expect(login).to be_truthy
    end

  end


end


