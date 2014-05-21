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
end
