require "rails_helper"

RSpec.feature "Add contributors to article", :type => :feature do
  before do
    @user = create(:user)
    @second_user = create(:user)
    @third_user = create(:user)
    @article = create(:article, user_id: @user.id)
    login_as(@user)
  end

  scenario "Add contributors" do
    visit "/"
    click_link "Articles"
    click_link @article.name
    click_link "Add contributor"
    expect(page).to have_content(@second_user.full_name)
    expect(page).to have_content(@third_user.full_name)
    first(:link, "Add").click

    expect(current_path).to eq(article_path(@article))
    expect(page).to have_content(@third_user.full_name)
    click_link "Add contributor"

    expect(page).to have_content(@second_user.full_name)
    click_link "Add"

    expect(current_path).to eq(article_path(@article))
    expect(page).to have_content(@second_user.full_name)
    expect(page).to have_content(@third_user.full_name)
  end
end
