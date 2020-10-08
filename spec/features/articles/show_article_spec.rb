require "rails_helper"

RSpec.feature "Show article", :type => :feature do
  before do
    @user = create(:user)
    @second_user = create(:user)
    @third_user = create(:user)
    @article = create(:article, user_id: @user.id, private: true)
    @article.contributors << @second_user
  end

  scenario "When not private, all users can access" do
    @article.private = false
    @article.save
    login_as(@third_user)
    visit "/"
    click_link "Articles"
    click_link @article.name

    expect(page).to have_content(@article.name)
    expect(current_path).to eq(article_path(@article))
  end

  scenario "When private, a non writer or contributor cant access" do
    login_as(@third_user)
    visit "/"
    click_link "Articles"
    expect(page).to_not have_content(@article.name)
  end

  scenario "When private, a user can access" do
    login_as(@user)
    visit "/"
    click_link "Articles"
    click_link @article.name

    expect(page).to have_content(@article.name)
    expect(current_path).to eq(article_path(@article))
  end

  scenario "When private, a contributor can access" do
    login_as(@second_user)
    visit "/"
    click_link "Articles"
    click_link @article.name

    expect(page).to have_content(@article.name)
    expect(current_path).to eq(article_path(@article))
  end
end
