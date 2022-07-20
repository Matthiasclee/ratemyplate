class RemovePlateFromPlates < ActiveRecord::Migration[6.1]
  def change
    remove_column :plates, :plate
  end
end
