require "rails_helper"

RSpec.feature "Sign Out", :type => :feature do
  before do
    @user = create(:user)
    login_as(@user)
  end

  scenario "A user sign out" do
    visit "/"
    expect(page).to have_content(@user.full_name)

    click_link "Signout"
    expect(page).to have_content("Signed out successfully.")
    expect(page).to_not have_content(@user.full_name)
    expect(page).to_not have_content("Signout")
  end
end
