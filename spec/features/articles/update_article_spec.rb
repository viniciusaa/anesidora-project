require "rails_helper"

RSpec.feature "Update article", :type => :feature do
  before do
    @user = create(:user)
    @article = create(:article, user_id: @user.id)
    login_as(@user)
    visit "/"
    click_link "Articles"
    click_link @article.name
    click_link "Edit article"
  end

  scenario "With valid name" do
    fill_in "Name", with: "TestName"
    click_button "Confirm"

    expect(page).to have_content("TestName")
    expect(page).to have_content("Article has been updated")
  end

  scenario "With invalid name" do
    fill_in "Name", with: ""
    click_button "Confirm"

    expect(page).to have_content("Failed to updated article")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Name is too short (minimum is 4 characters)")
  end
end
