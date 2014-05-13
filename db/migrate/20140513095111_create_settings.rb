class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :year
      t.integer :total_leaves

      t.timestamps
    end
  end
end
