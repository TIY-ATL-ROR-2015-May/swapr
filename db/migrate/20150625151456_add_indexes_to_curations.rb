class AddIndexesToCurations < ActiveRecord::Migration
  def change
    add_column :curations, :depth, :integer, default: 0, null: false
    add_index :curations, :rgt
    add_index :curations, :depth
  end
end
