require 'spec_helper'

describe "Settings" do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login(@user)
  end

  it "setting should have manage holidays link" do
    # given
    setting = FactoryGirl.create(:setting)

    # when
    visit settings_path

    # then
    page.should have_link('Manage Holidays')
  end

  it 'should render holidays index page' do
    # given
    setting = FactoryGirl.create(:setting)

    # when
    visit settings_path
    click_link('Manage Holidays')

    # then
    page.current_path.should eq("/settings/#{setting.id}/holidays")
  end

  it "should display all holidays list for year" do
    # given
    setting = FactoryGirl.create(:setting)
    holiday = FactoryGirl.create(:holiday, :setting => setting)

    # when
    visit settings_path

    # then
    page.should have_content setting.year
    page.should have_link('Manage Holidays')

    # when
    click_link('Manage Holidays')

    # then
    page.current_path.should eq("/settings/#{setting.id}/holidays")
    page.should have_content('Listing holidays')
    page.should have_content holiday.date
    page.should have_content holiday.occasion
    page.should have_link 'New Holiday'
  end

  it "should add new holiday for year" do
    # given
    @setting = FactoryGirl.create(:setting)
    visit settings_path

    # when
    click_link('Manage Holiday')

    # then
    page.should have_link('New Holiday')

    # when
    click_link('New Holiday')

    # then
    page.current_path.should eq("/settings/#{@setting.id}/holidays/new")

    # when
    fill_in 'Date', :with => '2014-12-31'
    fill_in 'Occasion', :with => 'Year End'
    click_button 'Save'

    # then
    page.should have_content 'Holiday was successfully created.'
    page.should have_content 'Year End'
    page.should have_content '2014-12-31'
    page.current_path.should eq("/settings/#{@setting.id}/holidays/#{Holiday.last.id}")

  end
end
