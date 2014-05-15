require 'spec_helper'

describe Setting do
  it "should be valid" do
    @valid_setting = {year: '2000', total_leaves: 10}
    Setting.new(@valid_setting).should be_valid
  end

  describe "year" do
    it "should be unique" do
      @setting = FactoryGirl.create(:setting)
      @new_setting = {year: @setting.year, total_leaves: 10}
      Setting.new(@new_setting).should_not be_valid

      @new_setting[:year] = "2000"
      Setting.new(@new_setting).should be_valid
    end

    it "should be present" do
      @setting = {year: nil, total_leaves: 10}
      Setting.new(@setting).should_not be_valid

      @setting = {year: '2000', total_leaves: 10}
      Setting.new(@setting).should be_valid
    end
  end
end
