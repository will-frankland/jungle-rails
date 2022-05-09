require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it "is valid" do
      user = User.new(
        name: 'name',
        email: 'test88@testing.com',
        password: 'pickles',
        password_confirmation: 'pickles'
      )
      expect(user).to be_valid
    end

    it "email is missing" do
      user = User.new(email: '')
      expect(user).to be_invalid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it "name is missing" do
      user = User.new(name: nil)
      expect(user).to be_invalid
      expect(user.errors.full_messages).to include("Name can't be blank")
    end

    it "password don't match" do
      user = User.new(
        name: 'name',
        email: 'test88@testing.com',
        password: 'pickles',
        password_confirmation: 'notTheSame'
      )
      user.password = 'random'
      user.valid?
      expect(user.errors.full_messages).to be_present
    end

    it 'email must be unique' do
      user = User.new
      user.name = 'name'
      user.email = 'test88@testing.com'
      user.password = 'pickles'
      user.password_confirmation = 'pickles'

      user.save
    
      user2 = User.new
      user2.name = 'name'
      user2.email = 'test88@testing.com'
      user2.password = 'pickles'
      user2.password_confirmation = 'pickles'
      user2.save
    
      expect(user2.errors.full_messages).to include('Email has already been taken')
    end

    it 'password length less than 5 characters is invalid' do
      user = User.new
      user.name = 'name'
      user.email = 'test88@testing.com'
      user.password = 'four'
      user.password_confirmation = 'four'
      expect(user).to be_invalid
    end

    it 'password length must be at-least 5 characters' do
      user = User.new
      user.name = 'name'
      user.email = 'test88@testing.com'
      user.password = 'Fives'
      user.password_confirmation = 'Fives'
      expect(user).to be_valid
    end
  end
  
  describe '.authenticate_with_credentials' do
    it 'should pass with valid credentials' do
      user = User.new(
        name: 'name',
        email: 'test88@testing.com',
        password: 'pickles',
        password_confirmation: 'pickles'
      )
      user.save

      user = User.authenticate_with_credentials('test88@testing.com', 'pickles')
      expect(user).not_to be(nil)
    end

    it 'should not pass with invalid credentials' do
      user = User.new(
        name: 'name',
        email: 'test88@testing.com',
        password: 'pickles',
        password_confirmation: 'pickles'
      )
      user.save

      user = User.authenticate_with_credentials('test88@testing.com', 'pass')
      expect(user).to be(nil)
    end

    it 'should pass even with spaces present in email' do
      user = User.new(
        name: 'name',
        email: 'test88@testing.com',
        password: 'pickles',
        password_confirmation: 'pickles'
      )
      user.save

      user = User.authenticate_with_credentials(' test88@testing.com ', 'pickles')
      expect(user).not_to be(nil)
    end

    it 'should pass even with caps present in email' do
      user = User.new(
        name: 'name',
        email: 'test88@testing.com',
        password: 'pickles',
        password_confirmation: 'pickles'
      )
      user.save

      user = User.authenticate_with_credentials('tesT88@tEstING.com', 'pickles')
      expect(user).not_to be(nil)
      end
    end
end