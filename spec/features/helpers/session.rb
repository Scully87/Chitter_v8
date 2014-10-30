module SessionHelpers

	def sign_up(user_name = "BigBoi87",
							name = "Chris Peacock",
							email = "BigBoi87@example.com",
							password = "toilet1",
							password_confirmation = "toilet1")
		visit '/users/new'
		fill_in :user_name, with: user_name
		fill_in :name, with: name
		fill_in :email, with: email
		fill_in :password, with: password
		fill_in :password_confirmation, with: password_confirmation
		click_button "Join Gritter!"
	end


	def sign_in(user_name = "BigBoi87", password = "toilet1")
		visit '/sessions/new'
		fill_in 'user_name', with: user_name
		fill_in 'password', with: password
		click_button "Sign In!"
	end

	def add_greet(body = "i love food")
		fill_in :body, with: body
		click_button 'Greet!'
	end
	
end