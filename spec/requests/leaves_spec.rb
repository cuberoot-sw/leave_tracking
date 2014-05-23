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

describe "Admin" do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login(@user)
  end

  it "should able to pending leaves" do
    # given
    visit root_path
    @leave = FactoryGirl.create(:apply_leave, :user_id => @user.id)

    # when
    click_link 'Manage Leaves'

    # then
    page.should have_content('Pending Leaves')
    page.should have_content('Applied By')
    page.should have_content('Number Of Days')

    page.should have_content(@user.name)
  end

  it "should approve pending leave" do
    # given
    visit root_path
    @leave = FactoryGirl.create(:apply_leave, :user_id => @user.id)

    # when
    click_link 'Manage Leaves'

    # then
    page.should have_link('Approve')
    page.should have_link('Reject')
  end
 end
