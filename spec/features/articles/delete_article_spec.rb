require "rails_helper"

RSpec.feature "Delete article", :type => :feature do
  before do
    @user = create(:user)
    @article = create(:article, user_id: @user.id)
    login_as(@user)
  end

  scenario "Delete article" do
    visit "/"
    click_link "Articles"
    expect(page).to have_content(@article.name)

    click_link "Delete article"

    expect(page).to have_content("Article was successfully deleted")
    expect(page).not_to have_content(@article.name)
  end
end
