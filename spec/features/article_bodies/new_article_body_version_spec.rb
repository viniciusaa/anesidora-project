require "rails_helper"

RSpec.feature "Create new body version", :type => :feature do
  before do
    @user = create(:user)
    @article = create(:article, user_id: @user.id)
    @article_body = create(:article_body, article_id: @article.id)
    login_as(@user)
    visit "/"
    click_link "Articles"
    click_link @article.name
    click_link "Create a new version from this one"
  end

  scenario "With valid input" do
    fill_in "Body", with: "Test New Article version"
    click_button "Confirm"

    expect(page).to have_content("Created new article body version")
    expect(page).to have_content("Test New Article version")
  end

  scenario "With invalid input" do
    fill_in "Body", with: ""
    click_button "Confirm"

    expect(page).to have_content("Failed to create new version")
    expect(page).to have_content("Body can't be blank")
    expect(page).to have_content("Body is too short (minimum is 4 characters)")
  end
end
