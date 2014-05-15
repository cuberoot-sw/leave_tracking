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

  it "add new" do
    # given
    setting = FactoryGirl.create(:setting)
    years = [2000, 2001]
    visit settings_path

    # when
    click_link "New Setting"

    # then
    page.current_path.should eq('/settings/new')

    # when
    select years[0], :from => 'setting_year'
    fill_in 'setting_total_leaves', :with => '10'
    click_button "Save"

    # then
    page.should have_content "Setting was successfully created."
    page.should have_content "2000"
    page.should have_content "10"
  end

  it "edit setting" do
    # given
      @setting = FactoryGirl.create(:setting)
      visit setting_path(@setting)

    # when
      find("a.edit_setting").click

    # then
      page.current_path.should eq("/settings/#{@setting.id}/edit")
      page.should have_content "Editing setting"
      find_field('setting_year').value.should eq(@setting.year.to_s)
      find_field('setting_total_leaves').value.should eq(@setting.total_leaves.to_s)
      find_button('Save')

    # when
      select '2014', :from => 'setting_year'
      fill_in 'setting_total_leaves', :with => '30'
      click_button "Save"

    # then
      page.should have_content "Setting was successfully updated."
      page.should have_content "30"
      page.should have_content @setting.year
  end

  it 'should render to edit page' do
    # given
    @setting = FactoryGirl.create(:setting)
    visit settings_path

    # when
    find("a.edit-setting").click

    # then
    page.current_path.should eq("/settings/#{@setting.id}/edit")
    page.should have_content "Editing setting"
  end

end
