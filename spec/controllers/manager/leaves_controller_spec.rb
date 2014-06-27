require 'spec_helper'

describe Manager::LeavesController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @manager = FactoryGirl.create(:user, :role => 'manager')
    @user = FactoryGirl.create(:employee, manager_id: @manager.id)
    sign_in @manager
  end

  describe 'reject action' do
    it "should reject pending leave" do
      @leave = FactoryGirl.create(:apply_leave, :user_id => @user.id)
      get :reject, {:user_id => @user.id, :id => @leave.id}
      expect(response).to redirect_to(manager_leaves_path)
      @leave = Leave.find(@leave.id)
      @leave.status.should eq('rejected')
    end
  end

  describe 'approve action' do
    it "should approve pending leave" do
      @leave = FactoryGirl.create(:apply_leave, :user_id => @user.id)
      get :approve, {:user_id => @user.id, :id => @leave.id}
      expect(response).to redirect_to(manager_leaves_path)
      @leave = Leave.find(@leave.id)
      @leave.status.should eq('approved')
    end
  end

end
