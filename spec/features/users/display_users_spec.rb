require "rails_helper"

RSpec.feature "Display users", :type => :feature do
  before do
    @user = create(:user)
    @second_user = create(:user)
    @third_user = create(:user)
    login_as(@user)
  end

  scenario "display users" do
    visit "/"
    click_link "Users"

    expect(page).to have_content(@user.full_name)
    expect(page).to have_content(@second_user.full_name)
    expect(page).to have_content(@third_user.full_name)
  end
end
