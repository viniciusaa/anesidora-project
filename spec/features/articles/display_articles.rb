require "rails_helper"

RSpec.feature "Display articles", :type => :feature do
  before do
    @user = create(:user)
    @first_article = create(:article)
    @second_article = create(:article)
    login_as(@user)
  end

  scenario "With valid name" do
    visit "/"
    click_link "Articles"

    expect(page).to have_content(@first_article.name)
    expect(page).to have_content(@second_article.name)
  end
end
