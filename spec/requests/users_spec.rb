require 'spec_helper'

describe "Users" do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login(@user)
  end

  it "should have Invite User link" do
    # when
    visit users_path

    # then
    page.should have_link 'Invite User'
  end
end
