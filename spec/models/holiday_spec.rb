require 'spec_helper'

describe Holiday do
  it "should be valid" do
    @setting = FactoryGirl.create(:setting)
    @valid_holiday = {date: '2014-12-31', occasion: 'Year End', setting: @setting}
    Holiday.new(@valid_holiday).should be_valid
  end

  describe "date" do
    it "should be unique" do
      @setting = FactoryGirl.create(:setting)
      @holiday = FactoryGirl.create(:holiday, setting: @setting)
      @new_holiday = {date: @holiday.date, occasion: 'new occasion'}
      Holiday.new(@new_holiday).should_not be_valid

      @new_holiday[:date] = "2014-05-01"
      Holiday.new(@new_holiday).should be_valid
    end

    it "should be present" do
      @setting = FactoryGirl.create(:setting)
      @holiday = {date: nil, occasion: 'occasion', setting: @setting}
      Holiday.new(@holiday).should_not be_valid

      @holiday = {date: '2014-01-01', occasion: 'occasion', setting: @setting}
      Holiday.new(@holiday).should be_valid
    end
  end

  describe "occasion" do
    it "should be present" do
      @setting = FactoryGirl.create(:setting)
      @holiday = {date: '2014-01-01', occasion: nil, setting: @setting}
      Holiday.new(@holiday).should_not be_valid

      @holiday = {date: '2014-01-01', occasion: 'occasion', setting: @setting}
      Holiday.new(@holiday).should be_valid
    end
  end

end
