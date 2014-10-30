require 'spec_helper'

feature "User browses the display of greets" do 

	before(:each){
		Greet.create(body: "i love food")
	}

	scenario "opens homepage and sees greets" do 
		visit '/'
		expect(page).to have_content("i love food")
	end

end