require "rails_helper"

RSpec.feature "Delete comment", :type => :feature do
  before do
    @user = create(:user)
    @article = create(:article, user_id: @user.id)
    @comment = create(:comment, article_id: @article.id, user_id: @user.id)
    login_as(@user)
  end

  scenario "Deleting comment" do
    visit "/"
    click_link "Articles"
    click_link @article.name
    click_link "Article discussion"

    expect(page).to have_content(@comment.body)
    click_link "Delete"

    expect(page).to have_content("Comment was successfully deleted")
  end
end
