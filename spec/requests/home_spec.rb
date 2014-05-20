require 'spec_helper'

describe "Home" do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login(@user)
  end

  it "should have Apply for leave option" do
    # when
    visit root_path

    # then
    page.should have_link 'Apply For Leave'

  end
end
