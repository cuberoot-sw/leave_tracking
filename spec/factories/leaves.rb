# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :leafe, :class => 'Leave' do
    start_date "2014-05-21"
    end_date "2014-05-21"
    no_of_days 1
    status "MyString"
    reason "MyString"
    approved_on "2014-05-21"
    approved_by 1
    rejection_reason "MyString"
    references ""
  end
end
