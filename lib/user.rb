#file: lib/user.rb

require 'bcrypt'

class User
    attr_accessor :id, :name, :email, :username
    attr_reader :password

    def password=(password)
      @password = password
      self.password_digest = BCrypt::Password.create(password)
    end
end
