#file: lib/user_repository.rb

require './lib/user'
require 'bcrypt'


class UserRepository
  
  def create(user)
    encrypted_password = BCrypt::Password.create(user.password)
 
    sql = 'INSERT INTO users (email, password, name, username) VALUES($1, $2, $3, $4);'
    params = [user.email, encrypted_password, user.name, user.username]
    result = DatabaseConnection.exec_params(sql, params)

    #return nil
  end

  def all
    users = []
    
    sql = 'SELECT * FROM users;'
    result_set  = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      users << create_user(record)
    end
      return users
  end

  def find_by_email(email)
    sql = 'SELECT * FROM users WHERE email = $1;'
    params = [email]

    result = DatabaseConnection.exec_params(sql, params)#[0] test if f then uncomment here
    return create_user(result[0]) #rm if f [0]
  end

  def log_in(email, submitted_password)#comment out all if f
    user = find_by_email(email)
    return nil if user.nil?
   
    return true if stored_password(user) == submitted_password

    return false
    
  end

  private

  def create_user(record)
    user = User.new
    user.id = record['id'].to_i
    user.email = record['email']
    user.password = record['password']
    user.name = record['name']
    user.username = record['username']
    
    return user
  end

  def stored_password(user)
    BCrypt::Password.new(user.password)
  end
end