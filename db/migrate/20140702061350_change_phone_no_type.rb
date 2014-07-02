class ChangePhoneNoType < ActiveRecord::Migration
  def change
    change_column :users, :phone_number, :string
    change_column :users, :alternate_phone_number, :string
  end
end
