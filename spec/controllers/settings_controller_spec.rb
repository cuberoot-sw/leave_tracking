require 'spec_helper'

describe SettingsController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  def valid_attributes
    setting = FactoryGirl.create(:setting)
    @setting = FactoryGirl.build(:setting).attributes
    # @setting.except!('created_at', 'updated_at', 'id')
  end


  describe 'handling index action' do
    it 'index action should render index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'new action' do
    it "should render new template" do
      get :new
      assigns(:setting).should be_a_new(Setting)
      expect(response).to render_template(:new)
    end
  end

  describe 'create action' do
    describe "with valid params" do
      it "creates a new Setting" do
        expect {
          post :create, setting: FactoryGirl.attributes_for(:setting)
        }.to change(Setting, :count).by(1)
      end

      it "assigns a newly created setting as @setting" do
        post :create, {:setting => FactoryGirl.attributes_for(:setting)}
        assigns(:setting).should be_a(Setting)
      end

      it "redirects to the created Setting" do
        post :create, {:setting => FactoryGirl.attributes_for(:setting)}
        expect(response).to redirect_to(Setting.last)
      end
    end
  end

  describe 'show action' do
    it 'should show requested setting' do
      @setting = FactoryGirl.create(:setting)
      get :show, {:id => @setting.id}
      expect(response).to render_template(:show)
    end
  end

  describe 'edit action' do
    it "assigns requested setting to @setting" do
      @setting = FactoryGirl.create(:setting)
      get :edit, {:id => @setting.id}
      assigns(:setting).should eq(@setting)
    end

    it "should render edit template" do
      @setting = FactoryGirl.create(:setting)
      get :edit, {:id => @setting.id}
      expect(response).to render_template(:edit)
    end
  end

  describe 'update action' do
    describe "with valid params" do
      it "should update requested setting" do
        @setting = FactoryGirl.create(:setting)
        @setting.total_leaves = 10
        put :update, { id: @setting, :setting => @setting.attributes }
        assigns(:setting).should eq(@setting)
      end

      it "should redirect to updated setting" do
        @setting = FactoryGirl.create(:setting)
        @setting.total_leaves = 10
        put :update, {:id => @setting, :setting => @setting.attributes }
        response.should redirect_to(@setting)
      end
    end
  end

  describe 'delete action' do
    it "should delete a Setting" do
      setting = FactoryGirl.create(:setting)
      expect {
        delete :destroy, id: setting.id
      }.to change(Setting, :count).by(-1)
    end
  end
end
