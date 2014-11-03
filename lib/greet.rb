require 'dm-timestamps'
require 'dm-validations'

class Greet

	include DataMapper::Resource

	property :id,         Serial
	property :body,       String
	property :user_name,  String
	property :name, 	  	String
	property :created_at, DateTime, :default => lambda{ |p,s| DateTime.now}

	has 1, :user, :through => Resource

end