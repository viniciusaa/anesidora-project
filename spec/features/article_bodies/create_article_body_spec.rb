require "rails_helper"

RSpec.feature "Create article body", :type => :feature do
  before do
    @user = create(:user)
    @article = create(:article, user_id: @user.id)
    login_as(@user)
    visit "/"
    click_link "Articles"
    click_link @article.name
    click_link "Create article body"
  end

  scenario "With valid input" do
    fill_in "Body", with: "Test New Article Body"
    click_button "Confirm"

    expect(page).to have_content("Body has been created")
    expect(page).to have_content("Test New Article Body")
  end

  scenario "With invalid input" do
    fill_in "Body", with: ""
    click_button "Confirm"

    expect(page).to have_content("Failed to create body")
    expect(page).to have_content("Body can't be blank")
    expect(page).to have_content("Body is too short (minimum is 4 characters)")
  end
end
