require 'spec_helper'

describe Leave do
  describe "start_date, end_date, reason" do
    it "should present" do
      @user = FactoryGirl.create(:employee)
      @leave = FactoryGirl.create(:apply_leave)
      @user.leaves.new(@leave.attributes).should be_valid

      @invalid_leave = {start_date: nil, end_date: nil, reason: nil}
      @user.leaves.new(@invalid_leave).should_not be_valid
    end
  end

  describe "Start Date" do
    it "should be less than or equal to end date" do
      @user = FactoryGirl.create(:employee)
      @leave = FactoryGirl.create(:apply_leave)
      @leave.start_date = Date.today
      @leave.end_date = Date.today - 1
      @user.leaves.new(@leave.attributes).should_not be_valid

      @leave.end_date = Date.today
      @user.leaves.new(@leave.attributes).should be_valid
    end
  end

  describe "status" do
    it "should be changed to approved from pending" do
      @user = FactoryGirl.create(:employee)
      @leave = FactoryGirl.create(:apply_leave, :user_id => @user.id)
      @leave.approve!
      @leave.status.should eq("approved")
    end

    it "should be changed to rejected from pending" do
      @user = FactoryGirl.create(:employee)
      @leave = FactoryGirl.create(:apply_leave, :user_id => @user.id)
      @leave.reject!
      @leave.status.should eq("rejected")
    end

    it "should be changed to cancelled from approved" do
      @user = FactoryGirl.create(:employee)
      @leave = FactoryGirl.create(:apply_leave, :user_id => @user.id)
      @leave.status = 'approved'
      @leave.cancel!
      @leave.status.should eq("cancelled")
    end

    it "should be changed to cancelled from rejected" do
      @user = FactoryGirl.create(:employee)
      @leave = FactoryGirl.create(:apply_leave, :user_id => @user.id)
      @leave.status = 'rejected'
      @leave.cancel!
      @leave.status.should eq("cancelled")
    end

    it "should be changed to cancelled from pending" do
      @user = FactoryGirl.create(:employee)
      @leave = FactoryGirl.create(:apply_leave, :user_id => @user.id)
      @leave.cancel!
      @leave.status.should eq("cancelled")
    end
  end
end
