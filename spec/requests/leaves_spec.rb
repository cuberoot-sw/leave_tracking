require 'spec_helper'

describe "Leaves" do
end

describe "Users" do
  before(:each) do
    @admin = FactoryGirl.create(:user, :role => 'manager')
    @user = FactoryGirl.create(:employee, manager_id: @admin.id)
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
    fill_in 'leaves_start_date', :with => Date.today
    fill_in 'leaves_end_date', :with => Date.today
    fill_in 'leave_reason', :with => 'Test Reason'
    click_button 'Save'

    # then
    page.should have_content('Leave was successfully created.')
    page.current_path.should eq("/users/#{@user.id}/leaves/#{Leave.last.id}")
    page.should have_content 'Test Reason'
    page.should have_content Date.today.strftime('%d %b %Y')

  end

  it "should edit leave" do
    # given
    visit root_path
    @leave = FactoryGirl.create(:apply_leave, :user_id => @user.id)

    # when
    click_link 'Manage Leaves'

    # then
    page.should have_link('Edit')

    # when
    click_link('Edit')
    fill_in 'leaves_start_date', :with => Date.today + 1
    fill_in 'leaves_end_date', :with => Date.today + 3
    fill_in 'leave_reason', :with => 'Edit Test Reason'
    click_button 'Save'

    # then
    page.should have_content('Leave was successfully updated.')
    page.current_path.should eq("/users/#{@user.id}/leaves/#{Leave.last.id}")
    page.should have_content 'Edit Test Reason'

  end
end

describe "manager" do
  before(:each) do
    @manager = FactoryGirl.create(:user, role: 'manager' )
    login(@manager)
  end

  it "should able to pending leaves" do
    # given
    @user = FactoryGirl.create(:employee, :manager_id => @manager.id)
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
    @user = FactoryGirl.create(:employee, :manager_id => @manager.id)
    visit root_path
    @leave = FactoryGirl.create(:apply_leave, :user_id => @user.id)

    # when
    click_link 'Manage Leaves'

    # then
    page.should have_link('Approve')
    page.should have_link('Reject')

    # when
    click_link 'Approve'

    # then
    page.should have_content('Leave was successfully Approved.')
    Leave.find(@leave.id).status.should eq('approved')
  end

  it "should reject pending leave" do
    # given
    @user = FactoryGirl.create(:employee, :manager_id => @manager.id)
    visit root_path
    @leave = FactoryGirl.create(:apply_leave, :user_id => @user.id)

    # when
    click_link 'Manage Leaves'

    # then
    page.should have_link('Approve')
    page.should have_link('Reject')

    # when
    click_link 'Reject'

    # then
    page.should have_content('Leave was successfully Rejected.')
    Leave.find(@leave.id).status.should eq('rejected')
  end

  it "should has facility to edit/delete his leaves" do
    # given
    @leave = FactoryGirl.create(:apply_leave, :user_id => @manager.id)

    # when
    visit leaves_path

    # then
    page.should have_link('Edit')
  end

 end
