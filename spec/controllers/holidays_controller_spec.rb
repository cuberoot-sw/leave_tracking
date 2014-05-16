require 'spec_helper'

describe HolidaysController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    sign_in @user
    @setting = FactoryGirl.create(:setting)
  end

  describe 'new action' do
    it "should render new template" do
      get :new, {:setting_id => @setting.id}
      assigns(:holiday).should be_a_new(Holiday)
      expect(response).to render_template(:new)
    end
  end

  describe 'create action' do

    it "creates a new holiday to a setting" do
      expect {
        post :create, {:holiday => FactoryGirl.attributes_for(:holiday), :setting_id => @setting.id}
      }.to change(Holiday, :count).by(1)
    end

    it "assigns newly created holiday" do
      post :create, {:holiday => FactoryGirl.attributes_for(:holiday), :setting_id => @setting.id}
      assigns(:holiday).should be_a(Holiday)
    end

    it "it should redirect to Holiday page" do
      post :create, {:holiday => FactoryGirl.attributes_for(:holiday), :setting_id => @setting.id}
      expect(response).to redirect_to(setting_holiday_path(@setting, Holiday.last))
    end
  end

  describe "show action" do

    it "assigns the requested holiday as @holiday" do
      holiday = FactoryGirl.create(:holiday, :setting => @setting)
      get :show, {:setting_id => @setting.id, :id => holiday.id}
      assigns(:holiday).should eq(holiday)
    end

    it 'should show requested holiday' do
      holiday = FactoryGirl.create(:holiday, :setting => @setting)
      get :show, {:setting_id => @setting.id, :id => holiday.id}
      response.should render_template(:show)
    end
  end


  describe 'edit action' do
    it "assigns requested holiday to @holiday" do
      holiday = FactoryGirl.create(:holiday, :setting => @setting)
      get :edit, {:id => holiday.id, :setting_id => @setting.id}
      assigns(:holiday).should eq(holiday)
    end

    it "should render edit template" do
      holiday = FactoryGirl.create(:holiday, :setting => @setting)
      get :edit, {:id => holiday.id, :setting_id => @setting.id}
      response.should render_template(:edit)
    end
  end

  describe 'update action' do
    before do
      @holiday = FactoryGirl.create(:holiday, :setting => @setting)
    end

    it "should update requested holiday" do
      @holiday.occasion = 'edited occasion'
      put :update, {:holiday => @holiday.attributes,
                    :id => @holiday.id,
                    :setting_id => @setting.id}
      assigns(:holiday).should eq(@holiday)
    end

    it "should redirect to updated holiday" do
      @holiday.occasion = 'edited occasion'
      put :update, {:holiday => @holiday.attributes,
                    :id => @holiday.id,
                    :setting_id => @setting.id}
      response.should redirect_to(setting_holiday_path(@setting, @holiday))
    end
  end

  describe 'delete action' do
    it "should delete a Holiday" do
      holiday = FactoryGirl.create(:holiday, :setting => @setting)
      expect {
        delete :destroy, id: holiday.id, :setting_id => @setting.id
      }.to change(Holiday, :count).by(-1)
    end
  end

end
