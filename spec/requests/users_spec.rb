require 'spec_helper'

describe "Admin" do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login(@user)
  end

  it "should have Invite User link" do
    # when
    visit users_path

    # then
    page.should have_link 'Invite Employee'
  end

  it "should invite the new employee" do

    # given
      visit users_path

    # when
      click_link 'Invite Employee'

    # then
      page.current_path.should eq(new_user_invitation_path)

    # when
      fill_in "Email", :with => "example@cuberoot.in"
      click_button "Send an invitation"

    # then
      page.current_path.should eq(root_path)
      page.should have_content "An invitation email has been sent to example@cuberoot.in."
  end

  it "invitation failed for invalid email" do
     # given
      visit users_path

    # when
      click_link 'Invite Employee'

    # then
      page.current_path.should eq(new_user_invitation_path)

    # when
      fill_in "Email", :with => "example@cuberoot.com"
      click_button "Send an invitation"

    # then
      page.current_path.should eq(user_invitation_path)
      page.should have_content "should be a cuberoot.in email"
  end


end
