require "rails_helper"

RSpec.feature "Sign In", :type => :feature do
  before do
    @user = create(:user)
    visit "/"
    click_link "Login"
  end

  scenario "With valid credentials" do
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content(@user.full_name)
    expect(page).to_not have_content("Login")
    expect(page).to_not have_content("Signup")
  end

  scenario "With invalid credentials" do
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    click_button "Log in"

    expect(page).to have_content("Invalid Email or password.")
  end
end
