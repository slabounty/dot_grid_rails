require 'spec_helper'

describe "Static pages" do
  describe "Home page" do
    it "has the content 'Dot Grid Rails'" do
      visit '/static_pages/home'
      expect(page).to have_content('Dot Grid Rails')
    end

    it "should have the title 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_title("Dot Grid Rails | Home")
    end
  end

  describe "Help page" do
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end

    it "should have the title 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_title("Dot Grid Rails | Help")
    end
  end

  describe "About page" do
    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_content('About Us')
    end

    it "should have the title 'About'" do
      visit '/static_pages/about'
      expect(page).to have_title("Dot Grid Rails | About")
    end
  end
end
