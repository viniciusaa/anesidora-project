require "rails_helper"

RSpec.feature "Contributor update article", :type => :feature do
  before do
    @user = create(:user)
    @second_user = create(:user)
    @article = create(:article, user_id: @user.id)
    @article_body = create(:article_body, article_id: @article.id)
    login_as(@second_user)
  end

  scenario "When is a contributor" do
    @article.contributors << @second_user
    visit "/"
    click_link "Articles"
    click_link @article.name
    click_link "Create a new version from this one"
    fill_in "Body", with: "Test New Article version"
    click_button "Confirm"

    expect(page).to have_content("Created new article body version")
    expect(page).to have_content("Test New Article version")
  end

  scenario "When not a contributor" do
    visit "/"
    click_link "Articles"
    click_link @article.name
    expect(page).to_not have_link("Create a new version from this one")
  end
end
