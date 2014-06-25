# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
#
#
# In this application we use two user_roles
# 1. Admin can access anything
# 2. employee has access to leaves
puts 'Please wait ...'
@admin = User.create(name: 'admin',
            email: 'admin@cuberoot.in',
            password: 'admin123',
            password_confirmation: 'admin123',
            date_of_joining: Time.now
           )
# admin's managee is self here.
@admin.role = 'admin'
@admin.manager_id = @admin.id
@admin.save

puts 'Admin has been created successfully with-'
puts 'email: admin@cuberoot.in'
puts 'password: admin123'

