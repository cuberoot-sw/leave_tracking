require 'spec_helper'

describe "Settings" do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login(@user)
  end

  it "should render settings index page" do
    # when
    visit settings_path
    setting = FactoryGirl.create(:setting)

    # then
    page.should have_content(setting.year)
    page.should have_content('New Setting')
  end
end
