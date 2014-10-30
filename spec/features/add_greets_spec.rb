require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "Users can" do 

	before(:each){
	  User.create(user_name: "BigBoi87",
								name: "Chris Peacock",
								email: "bigboi87@exampl.example.com",
								password: "toilet1",
								password_confirmation: "toilet1")
	}

	scenario "only post when signed in" do
		visit '/'
		expect(page).not_to have_content("Greet :")
		sign_in
		expect(page).to have_content("Greet :")
	end

	scenario "make a post" do
		sign_in
		add_greet
		expect(page).to have_content("i love food")
		expect(page).to have_content("BigBoi87")
	end

end