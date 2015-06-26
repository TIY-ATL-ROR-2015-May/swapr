class SwitchToNestedSet < ActiveRecord::Migration
  def change
    add_column :curations, :lft, :integer
    add_column :curations, :rgt, :integer
  end
end
