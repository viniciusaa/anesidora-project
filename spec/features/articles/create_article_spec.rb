require "rails_helper"

RSpec.feature "Create article", :type => :feature do
  before do
    @user = create(:user)
    login_as(@user)
    visit "/"
    click_link "Articles"
    click_link "New Article"
  end

  scenario "With valid name" do
    fill_in "Name", with: "TestName"
    click_button "Confirm"

    expect(page).to have_content("TestName")
    expect(page).to have_content("Create article body")
  end

  scenario "With invalid name" do
    fill_in "Name", with: ""
    click_button "Confirm"

    expect(page).to have_content("Failed to create article")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Name is too short (minimum is 4 characters)")
  end
end
