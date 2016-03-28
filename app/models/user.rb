require 'bcrypt'
require 'dm-core'
require 'dm-validations'

class User
  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password
  validates_presence_of :email
  validates_uniqueness_of :username
  validates_uniqueness_of :email

  property :id, Serial
  property :username, String, :lazy => false
  property :email, Text, :lazy => false, :required => true, :format => :email_address
  property :password_digest, Text, :lazy => false

  has n, :peeps, through: Resource

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(username, password)
    user = first(username: username)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end

  end

end
