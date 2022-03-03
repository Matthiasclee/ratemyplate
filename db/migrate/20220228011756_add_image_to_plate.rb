class AddImageToPlate < ActiveRecord::Migration[6.1]
  def change
    add_column :plates, :image, :binary
  end
end
