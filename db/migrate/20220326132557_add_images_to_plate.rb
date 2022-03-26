class AddImagesToPlate < ActiveRecord::Migration[6.1]
  def change
    add_column :plates, :images, :binary, array: true, default: []
  end
end
