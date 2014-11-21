class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.references :river, index: true
      t.references :state, index: true
      t.string :name
      t.string :water_class
      t.decimal :takeout_long
      t.decimal :takeout_lat
      t.decimal :putin_long
      t.decimal :putin_lat

      t.timestamps
    end
  end
end
