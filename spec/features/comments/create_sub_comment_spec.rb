require "rails_helper"

RSpec.feature "Create sub-comment", :type => :feature do
  before do
    @user = create(:user)
    @article = create(:article, user_id: @user.id)
    @comment = create(:comment, article_id: @article.id, user_id: @user.id)
    login_as(@user)
  end

  scenario "With valid entry" do
    visit "/"
    click_link "Articles"
    click_link @article.name
    click_link "Article discussion"

    expect(page).to have_content(@comment.body)
    click_link "Reply"

    expect(current_path).to eq(new_article_comment_sub_comment_path(@article, @comment))
    fill_in "Reply", with: "Testing sub-comment"
    click_button "Post"

    expect(current_path).to eq(article_comments_path(@article))
    expect(page).to have_content("Comment published")
    expect(page).to have_content("Testing sub-comment")
  end

  scenario "With invalid entry" do
    visit "/"
    click_link "Articles"
    click_link @article.name
    click_link "Article discussion"

    expect(page).to have_content(@comment.body)
    click_link "Reply"

    expect(current_path).to eq(new_article_comment_sub_comment_path(@article, @comment))
    fill_in "Reply", with: ""
    click_button "Post"

    expect(current_path).to eq(article_comments_path(@article))
    expect(page).to have_content("Failed to publish comment")
  end
end
