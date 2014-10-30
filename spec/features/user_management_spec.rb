require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "new user signs up" do

	scenario "with correct details" do
		visit '/'
		sign_up
		expect(User.count).to eq 1
		expect(page).to have_content("Hey, BigBoi87")		
	end

	scenario "with password and password confirmation not matching" do
		visit '/'
		sign_up("BigBoi87", "Chris Peacock", "bigboi87@example.com", "toilet1", "wrongtoilet1")
		expect(User.count).to eq(0)
		expect(current_path).to eq '/users'
		expect(page).to have_content("Password does not match the confirmation")
	end

	scenario "not with a unique email address or user name" do
		visit '/'
		sign_up
		sign_up("BigBoi87", "Chris Peacock", "bigboi87@example.com", "toilet1", "wrongtoilet1")
		expect(current_path).to eq '/users'
		expect(page).to have_content("Sorry, there were the following problems with the form")
	end

end

feature "existing user signs back in" do

	before(:each){
		 User.create(user_name: "BigBoi87",
								password: "toilet1",
								password_confirmation: "toilet1")
	}
	
	scenario "with correct credentials" do
		visit '/'
		expect(page).not_to have_content("Hey, BigBoi87")
		sign_in("BigBoi87", "toilet1")
		expect(page).to have_content("Hey, BigBoi87")
	end

	scenario "with incorrect credentials" do
		visit '/'
		expect(page).not_to have_content("Hey, BigBoi87")
		sign_in("BigBoi87", "wrongtoilet1")
		expect(page).not_to have_content("Hey, BigBoi87")
	end

end

feature "existing user signs out" do

	before(:each){
		User.create(user_name: "BigBoi87",
								password: "toilet1",
								password_confirmation: "toilet1")
	}
	
	scenario "whilst being signed in" do
		sign_in("BigBoi87", "toilet1")
		click_button "Sign Out!"
		expect(page).to have_content("See you soon!")
		expect(page).not_to have_content("Welcome, BigBoi87")
	end

end