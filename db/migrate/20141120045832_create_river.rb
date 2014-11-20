class CreateRiver < ActiveRecord::Migration
  def change
    create_table :rivers do |t|
      t.string :name
    end
  end
end
