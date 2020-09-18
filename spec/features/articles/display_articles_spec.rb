require "rails_helper"

RSpec.feature "Display article", :type => :feature do
  before do
    @user = create(:user)
    @second_user = create(:user)
    @first_article = create(:article, user_id: @user.id)
    @second_article = create(:article, user_id: @second_user.id)
    login_as(@user)
  end

  scenario "display article" do
    visit "/"
    click_link "Articles"

    expect(page).to have_content(@first_article.name)
    expect(page).to have_content(@second_article.name)
  end
end
