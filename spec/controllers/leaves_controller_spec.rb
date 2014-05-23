require 'spec_helper'

describe LeavesController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:employee)
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

end
