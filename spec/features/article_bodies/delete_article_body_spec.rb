require "rails_helper"

RSpec.feature "Delete", :type => :feature do
  before do
    @user = create(:user)
    @article = create(:article, user_id: @user.id)
    @article_body = create(:article_body, article_id: @article.id)
    login_as(@user)
    visit "/"
    click_link "Articles"
    click_link @article.name
  end

  scenario "article body version" do
    expect(page).to have_content(@article_body.body)
    click_link "Delete version"

    expect(page).to have_content("Body version was successfully deleted")
    expect(page).not_to have_content(@article_body.body)
  end
end
