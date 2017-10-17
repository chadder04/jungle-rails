require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should be valid with valid data' do
      @user = User.create(name: 'Test User', email: 'test@user.com', password: '123', password_confirmation: '123')
      expect(@user).to be_persisted
    end
    it 'should be invalid if no password found' do
      @user = User.create(name: 'Test User', email: 'test@user.com', password: nil, password_confirmation: '123')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include('Password can\'t be blank')
    end
    it 'should be invalid if no password_confirmation found' do
      @user = User.create(name: 'Test User', email: 'test@user.com', password: '123', password_confirmation: nil)
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include('Password confirmation can\'t be blank')
    end
    it 'should be invalid if password fields do not match' do
      @user = User.create(name: 'Test User', email: 'test@user.com', password: '1234', password_confirmation: '123')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include('Password confirmation doesn\'t match Password')
    end
    it 'should be invalid with existing email address' do
      @user1 = User.create(name: 'Test User', email: 'test@user.com', password: '123', password_confirmation: '123')
      @user2 = User.create(name: 'Test User', email: 'test@user.com', password: '123', password_confirmation: '123')
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include('Email has already been taken')
    end
    it 'should be invalid with no email address' do
      @user = User.create(name: 'Test User', email: nil, password: '123', password_confirmation: '123')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include('Email can\'t be blank')
    end
    it 'should be invalid with no name' do
      @user = User.create(name: nil, email: 'test@user.com', password: '123', password_confirmation: '123')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include('Name can\'t be blank')
    end
    it 'should be invalid with password length shorter than 3 characters' do
      @user = User.create(name: 'Test User', email: 'test@user.com', password: '12', password_confirmation: '12')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 3 characters)')
    end
  end
  describe '.authenticate_with_credentials' do
    it 'should be valid with correct email and password' do
      @user1 = User.create(name: 'Test User', email: 'test@user.com', password: '123456', password_confirmation: '123456')      
      email = 'test@user.com'
      password = '123456'
      @user2 = User.authenticate_with_credentials(email, password)
      expect(@user2).to_not be_nil
    end
    it 'should be nil with no email address' do
      @user1 = User.create(name: 'Test User', email: 'test@user.com', password: '123456', password_confirmation: '123456')      
      email = nil
      password = '123456'
      @user2 = User.authenticate_with_credentials(email, password)
      expect(@user2).to be_nil
    end
    it 'should be nil with no password' do
      @user1 = User.create(name: 'Test User', email: 'test@user.com', password: '123456', password_confirmation: '123456')      
      email = 'test@user.com'
      password = nil
      @user2 = User.authenticate_with_credentials(email, password)
      expect(@user2).to be_nil
    end
    it 'should be nil with incorrect email address' do 
      @user1 = User.create(name: 'Test User', email: 'test@user.com', password: '123456', password_confirmation: '123456')      
      email = 'te2st@user.com'
      password = '123456'
      @user2 = User.authenticate_with_credentials(email, password)
      expect(@user2).to be_nil
    end
    it 'should be nil with incorrect password' do 
      @user1 = User.create(name: 'Test User', email: 'test@user.com', password: '123456', password_confirmation: '123456')      
      email = 'test@user.com'
      password = '1234522226'
      @user2 = User.authenticate_with_credentials(email, password)
      expect(@user2).to be_nil
    end
    it 'should be valid with trailing spaces in email addresses' do
      @user1 = User.create(name: 'Test User', email: 'test@user.com', password: '123456', password_confirmation: '123456')      
      email = ' test@user.com '
      password = '123456'
      @user2 = User.authenticate_with_credentials(email, password)
      expect(@user2).to_not be_nil
    end
    it 'should be valid with different cases in email address' do
      @user1 = User.create(name: 'Test User', email: 'test@user.com', password: '123456', password_confirmation: '123456')      
      email = 'teST@uSER.com'
      password = '123456'
      @user2 = User.authenticate_with_credentials(email, password)
      expect(@user2).to_not be_nil
    end
  end
end
