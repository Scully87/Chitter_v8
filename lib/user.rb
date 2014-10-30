require 'bcrypt'
require 'dm-validations'

class User

	include DataMapper::Resource

	property :id, 			       Serial
	property :user_name, 	       String, required: true, unique: true, length: 1..50
	property :name, 		       String, length: 1..50
	property :email, 		       String, required: true, unique: true, length: 1..150
	property :password_digest,     Text,   required: true, length: 1..150

	has n, :greets, :through => Resource

	attr_reader :password
	attr_accessor :password_confirmation

	validates_confirmation_of :password
	validates_uniqueness_of :user_name, :email

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(user_name, password)
		user = first(user_name: user_name)
		if user && BCrypt::Password.new(user.password_digest) == password
			user
		else
			nil
		end
	end

end