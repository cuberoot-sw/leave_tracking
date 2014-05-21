class CreateLeaves < ActiveRecord::Migration
  def change
    create_table :leaves do |t|
      t.date :start_date
      t.date :end_date
      t.integer :no_of_days
      t.string :status
      t.string :reason
      t.date :approved_on
      t.integer :approved_by
      t.string :rejection_reason
      t.references :user

      t.timestamps
    end
  end
end
