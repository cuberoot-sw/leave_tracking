FactoryGirl.define do
  factory :user do |f|
    sequence(:name) {|u| "user#{u}"}
    sequence(:email) {|n| "user#{n}@cuberoot.in"}
    password 'password123'
    password_confirmation 'password123'
    role 'admin'
    # after(:create) { |user| user.role = 'admin'}
  end

end
