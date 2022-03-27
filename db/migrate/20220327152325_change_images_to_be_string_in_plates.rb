class ChangeImagesToBeStringInPlates < ActiveRecord::Migration[6.1]
  def change
    change_column :plates, :images, :string, array: true, default: []
  end
end
