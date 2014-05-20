FactoryGirl.define do
  factory :user do |f|
    sequence(:name) {|u| "user#{u}"}
    sequence(:email) {|n| "user#{n}@cuberoot.in"}
    password 'password123'
    password_confirmation 'password123'

    alternate_email 'example@cuberoot.com'
    phone_number '1234567890'
    alternate_phone_number '1234567890'
    blood_group 'A'
    date_of_birth Time.now
    date_of_joining Time.now
    skype_id 'exampleadmin'
    github_id 'example_admin'
    local_address 'pune'
    permanent_address 'pune'
    manager_id 1

    role 'admin'
  end

  factory :employee, class: User do
    sequence(:name) {|u| "user#{u}"}
    sequence(:email) {|n| "user#{n}@cuberoot.in"}
    password 'password123'
    password_confirmation 'password123'
    role 'employee'

    alternate_email 'example@cuberoot.com'
    phone_number '1234567890'
    alternate_phone_number '1234567890'
    blood_group 'A'
    date_of_birth Time.now
    date_of_joining Time.now
    skype_id 'john'
    github_id 'johnp'
    local_address 'pune'
    permanent_address 'pune'
    manager_id 1

  end
end
