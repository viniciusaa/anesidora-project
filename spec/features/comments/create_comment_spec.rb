require "rails_helper"

RSpec.feature "Create comment", :type => :feature do
  before do
    @user = create(:user)
    @article = create(:article, user_id: @user.id)
    login_as(@user)
  end

  scenario "With valid entry" do
    visit "/"
    click_link "Articles"
    click_link @article.name
    click_link "Article discussion"

    expect(current_path).to eq(article_comments_path(@article))
    fill_in "Comment", with: "Testing comment"
    click_button "Post"

    expect(page).to have_content("Comment published")
    expect(page).to have_content("Testing comment")
  end

  scenario "With invalid entry" do
    visit "/"
    click_link "Articles"
    click_link @article.name
    click_link "Article discussion"

    expect(current_path).to eq(article_comments_path(@article))
    fill_in "Comment", with: ""
    click_button "Post"

    expect(page).to have_content("Failed to publish comment")
  end
end
