require 'bcrypt'

class Admin < ActiveRecord::Base
  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end
  
    has_secure_password

    validates :username, uniqueness: true
    validates :username, :password, presence: true
end
