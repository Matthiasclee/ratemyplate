class RemoveImageurlFromPlates < ActiveRecord::Migration[6.1]
  def change
    remove_column :plates, :imageurl, :string
  end
end
