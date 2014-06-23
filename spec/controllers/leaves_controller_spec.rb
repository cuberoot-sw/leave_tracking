require 'spec_helper'

describe LeavesController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @manager = FactoryGirl.create(:user)
    @user = FactoryGirl.create(:employee, manager_id: @manager.id)
    sign_in @user
  end

  describe 'New Action' do
    it "should render new template" do
      get :new, {:user_id => @user.id}
      assigns(:leave).should be_a_new(Leave)
      expect(response).to render_template(:new)
    end
  end

  describe 'create action' do
    it "creates a new leave to a user" do
      expect {
        post :create, {:leave => FactoryGirl.attributes_for(:apply_leave), :user_id => @user.id}
      }.to change(Leave, :count).by(1)
    end

    it "assigns newly created leave" do
      post :create, {:leave => FactoryGirl.attributes_for(:apply_leave), :user_id => @user.id}
      assigns(:leave).should be_a(Leave)
    end

    it "it should redirect to users leave page" do
      post :create, {:leave => FactoryGirl.attributes_for(:apply_leave), :user_id => @user.id}
      expect(response).to redirect_to(user_leafe_path(@user, Leave.last))
    end
  end

  describe 'Leave status' do
    it "should be pending by default" do
      post :create, {:leave => FactoryGirl.attributes_for(:apply_leave), :user_id => @user.id}
      @leave = Leave.last
      @leave.status.should eq('pending')
    end
  end

  describe 'approve action' do
    it "should approve pending leave" do
      @leave = FactoryGirl.create(:apply_leave, :user_id => @user.id)
      get :approve, {:user_id => @user.id, :id => @leave.id}
      expect(response).to redirect_to(leaves_path)
      @leave = Leave.find(@leave.id)
      @leave.status.should eq('approved')
    end
  end

  describe 'reject action' do
    it "should reject pending leave" do
      @leave = FactoryGirl.create(:apply_leave, :user_id => @user.id)
      get :reject, {:user_id => @user.id, :id => @leave.id}
      expect(response).to redirect_to(leaves_path)
      @leave = Leave.find(@leave.id)
      @leave.status.should eq('rejected')
    end
  end

  describe 'cancel action' do
    it "should cancel leave" do
      @leave = FactoryGirl.create(:apply_leave, :user_id => @user.id)
      get :cancel, {:user_id => @user.id, :id => @leave.id}
      expect(response).to redirect_to(leaves_path)
      @leave = Leave.find(@leave.id)
      @leave.status.should eq('cancelled')
    end
  end

  describe 'edit action' do
    it "assigns requested leave to @leave" do
      leave = FactoryGirl.create(:apply_leave, :user_id => @user.id)
      get :edit, {:id => leave.id, :user_id => @user.id}
      assigns(:leave).should eq(leave)
    end

    it "should render edit template" do
      leave = FactoryGirl.create(:apply_leave, :user_id => @user.id)
      get :edit, {:id => leave.id, :user_id => @user.id}
      response.should render_template(:edit)
    end
  end

  describe 'update action' do
    before do
      @leave = FactoryGirl.create(:apply_leave, :user_id => @user.id)
    end

    it "should update requested leave" do
      @leave.reason = 'edited reason'
      put :update, {:leave => @leave.attributes,
                    :id => @leave.id,
                    :user_id => @user.id}
      assigns(:leave).should eq(@leave)
    end

    it "should redirect to updated leave" do
      @leave.reason = 'edited reason'
      put :update, {:leave => @leave.attributes,
                    :id => @leave.id,
                    :user_id => @user.id}
      response.should redirect_to(user_leafe_path(@user, @leave))
    end
  end

  describe 'delete action' do
    it "should delete a leave" do
      leave = FactoryGirl.create(:apply_leave, :user_id => @user.id)
      expect {
        delete :destroy, id: leave.id, :user_id => @user.id
      }.to change(Leave, :count).by(-1)
    end
  end

  describe "show action" do
    it "assigns the requested leave as @leave" do
      leave = FactoryGirl.create(:apply_leave, :user => @user)
      get :show, {:user_id => @user.id, :id => leave.id}
      assigns(:leave).should eq(leave)
    end

    it 'should show requested leave' do
      leave = FactoryGirl.create(:apply_leave, :user => @user)
      get :show, {:user_id => @user.id, :id => leave.id}
      response.should render_template(:show)
    end
  end
end
