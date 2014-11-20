class CreateJoinTableSection < ActiveRecord::Migration
  def change
    create_join_table :river, :state, table_name: :section
    t.index :river_id
    t.index :state_id
    t.string :name
    t.string :water_class
    t.decimal :takeout_long
    t.decimal :takeout_lat
    t.decimal :putin_long
    t.decimal :putin_lat
  end
end
