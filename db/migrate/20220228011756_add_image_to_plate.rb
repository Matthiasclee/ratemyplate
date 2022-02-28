class AddImageToPlate < ActiveRecord::Migration[6.1]
  def change
    add_column :plates, :image, :string
  end
end
