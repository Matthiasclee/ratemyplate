class RemoveStateFromPlates < ActiveRecord::Migration[6.1]
  def change
    remove_column :plates, :state
  end
end
