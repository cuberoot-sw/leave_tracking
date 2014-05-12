class AddUserFields < ActiveRecord::Migration
  def change
    add_column :users, :alternate_email, :string
    add_column :users, :name, :string
    add_column :users, :phone_number, :integer
    add_column :users, :alternate_phone_number, :integer

    add_column :users, :blood_group, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :date_of_joining, :date

    add_column :users, :skype_id, :string
    add_column :users, :github_id, :string
    add_column :users, :local_address, :text
    add_column :users, :permanent_address, :text
  end
end
