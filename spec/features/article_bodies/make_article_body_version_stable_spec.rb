require "rails_helper"

RSpec.feature "Make article body version stable", :type => :feature do
  before do
    @user = create(:user)
    @article = create(:article, user_id: @user.id)
    @article_body = create(:article_body, article_id: @article.id)
    login_as(@user)
  end

  scenario "Make article body stable" do
    visit "/"
    click_link "Articles"
    click_link @article.name
    click_link "Make version stable"

    expect(page).to have_content("Version is now the stable")
    expect(page).to have_content("Stable body version")
  end
end
