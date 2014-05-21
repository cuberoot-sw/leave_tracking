require 'spec_helper'

describe "Leaves" do
end

describe "Users" do
  before(:each) do
    @user = FactoryGirl.create(:employee)
    login(@user)
  end
  it "should apply new leave" do
    # given
    visit root_path

    # when
    click_link('Apply For Leave')

    # then
    page.current_path.should eq("/users/#{@user.id}/leaves/new")

    # when
    fill_in 'Start Date', :with => Date.today
    fill_in 'End Date', :with => Date.today
    fill_in 'Reason', :with => 'Test Reason'
    click_button 'Save'

    # then
    page.should have_content('Leave was successfully created.')
    page.current_path.should eq("/users/#{@user.id}/leaves/#{Leave.last.id}")
    page.should have_content 'Test Reason'
    page.should have_content Date.today.strftime('%d %b %Y')

  end
end
