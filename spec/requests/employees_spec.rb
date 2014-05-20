describe "Employee" do
  before(:each) do
    @user = FactoryGirl.create(:employee)
    login(@user)
  end

  it "should view profile" do
    # given
    # visit root_path

    # then
    page.should have_link 'Profile'

    # when
    click_link 'Profile'

    # then
    page.current_path.should eq(profile_path(@user))
    page.should have_content(Date.today.strftime('%d %b %Y'))
    page.should have_content(@user.date_of_joining)
  end

end
