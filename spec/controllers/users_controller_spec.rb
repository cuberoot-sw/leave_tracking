require 'spec_helper'

describe UsersController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:employee)
    sign_in @user
  end

  describe "show action" do
    it 'should show requested user profile' do
      @user = FactoryGirl.create(:employee)
      get :show, {:id => @user.id}
      expect(response).to render_template(:show)
    end
  end
end

