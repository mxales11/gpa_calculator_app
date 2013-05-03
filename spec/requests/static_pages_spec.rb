require 'spec_helper'

describe "Static pages" do 

	describe "Home page" do

		it "should have the h1 'GPA Projections App'" do 
			visit root_path
			page.should have_selector('h1', text: 'GPA Projections App')
		end

		it "should have the base title" do
			visit root_path
			page.should have_selector('title', text: 'GPA Projections App')
		end

		it "should not have a custom page title" do
			visit root_path
			page.should_not have_selector('title', text: '| Home')
		end
	end


	describe "Help page" do
		it "should have the h1 'Help'" do 
			visit help_path
			page.should have_selector('h1', text: 'Help')
		end

		it "should have the title 'Help" do
			visit help_path
			page.should have_selector('title', text: 'GPA Projections App | Help')
		end
	end

	describe "About page" do

		it "should have the h1 'About Application'" do 
			visit about_path
			page.should have_selector('h1', text: 'About Us')
		end

		it "should have the title 'About'" do
			visit about_path
			page.should have_selector('title', text: 'GPA Projections App | About')
		end
	end
end