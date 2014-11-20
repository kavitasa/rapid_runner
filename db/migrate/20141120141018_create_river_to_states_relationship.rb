class CreateRiverToStatesRelationship < ActiveRecord::Migration
  def change
    create_join_table :river, :state do |t|
      t.index :river_id
      t.index :state_id
    end
  end
end
