#file: spec/user_repository_spec.rb

require 'spec_helper'
require 'user_repository'
require 'bcrypt'

RSpec.describe UserRepository do

  before(:each) do
    reset_all_tables
  end

  it 'returns all users' do
    repo = UserRepository.new
    users = repo.all

    expect(users.length).to eq (2)
    expect(users[0].id).to eq (1)
    expect(users[0].email).to eq ('hothot@hotmail.com')
    expect(users[0].name).to eq ('ken')
    expect(users[0].username).to eq ('ken8989')
    #expect(users[1].id).to eq (2)
    #expect(users[1].email).to eq ('starjan@hotmail.com')
    #expect(users[1].name).to eq ('jan')
    #expect(users[1].username).to eq ('jan2345')
  end

  it 'creates a new user' do
    repo = UserRepository.new
    created_user = User.new
    created_user.name = 'newpeep'
    created_user.username = 'np1234'
    created_user.email = 'newpeep@hotmail.com'
    created_user.password = 'lovelynp123'

    repo.create(created_user)
    users = repo.all

    last_users = users.last
    expect(users.length).to eq(3)
    expect(last_users.name).to eq('newpeep')
    expect(last_users.email).to eq('newpeep@hotmail.com')
    expect(last_users.username).to eq('np1234')
    expect(BCrypt::Password.new(last_users.password)).to eq('lovelynp123')
  end


  it 'find user by email' do
    repo = UserRepository.new
    user = repo.find_by_email('hothot@hotmail.com')
    
    expect(user.name).to eq('ken')
    expect(user.password).to eq('dada123')
  end

  it 'logs a user in if email and password matched' do
    logged_user = User.new
    logged_user.name = ('newpeep')
    logged_user.email = ('newpeep@hotmail.com')
    logged_user.username = ('np1234')
    logged_user.password = ('lovelynp123')
    
    users = UserRepository.new
    users.create(logged_user)
    result = users.log_in('newpeep@hotmail.com', 'lovelynp123')
    expect(result).to eq true
  end

  it 'fails if a user attempt to log in with unmatched email and password' do
    logged_user = User.new
    logged_user.name = ('newpeep')
    logged_user.email = ('newpeep@hotmail.com')
    logged_user.username = ('np1234')
    logged_user.password = ('lovelynp123')

    users = UserRepository.new
    users.create(logged_user)
    result = users.log_in('newpeep@hotmail.com', 'lynp23')
    expect(result).to eq false
  end
end