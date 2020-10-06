require "rails_helper"

RSpec.feature "Remove contributor from article", :type => :feature do
  before do
    @user = create(:user)
    @second_user = create(:user)
    @article = create(:article, user_id: @user.id)
    @article.contributors << @second_user
    login_as(@user)
  end

  scenario "Remove contributor" do
    visit "/"
    click_link "Articles"
    click_link @article.name
    expect(page).to have_content(@second_user.full_name)
    click_link "Remove"

    expect(page).to_not have_content(@second_user.full_name)
  end
end
