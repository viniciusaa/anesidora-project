require "rails_helper"

RSpec.feature "Sign Up", :type => :feature do
  before do
    visit "/"
    click_link "Signup"
  end

  scenario "With valid credentials" do
    fill_in "Email", with: "test@example.com"
    fill_in "First name", with: "First"
    fill_in "Last name", with: "Last"
    fill_in "Password", with: "123456"
    fill_in "Password confirmation", with: "123456"
    click_button "Sign up"

    expect(page).to have_content("You have signed up successfully.")
    expect(page).to have_content("First Last")
  end

  scenario "With invalid credentials" do
    fill_in "Email", with: ""
    fill_in "First name", with: ""
    fill_in "Last name", with: ""
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    click_button "Sign up"

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Password can't be blank")
  end
end
