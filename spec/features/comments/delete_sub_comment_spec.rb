require "rails_helper"

RSpec.feature "Delete sub-comment", :type => :feature do
  before do
    @user = create(:user)
    @second_user = create(:user)
    @article = create(:article, user_id: @user.id)
    @comment = create(:comment, article_id: @article.id, user_id: @user.id)
    @sub_comment = create(:sub_comment, comment_id: @comment.id, user_id: @second_user.id)
    login_as(@second_user)
  end

  scenario "Deleting sub-comment" do
    visit "/"
    click_link "Articles"
    click_link @article.name
    click_link "Article discussion"

    expect(page).to have_content(@comment.body)
    expect(page).to have_content(@sub_comment.body)
    click_button "delete"

    expect(page).to have_content("Comment deleted")
    expect(page).to_not have_content(@sub_comment.body)
  end
end
