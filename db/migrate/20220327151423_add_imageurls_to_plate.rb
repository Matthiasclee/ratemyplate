class AddImageurlsToPlate < ActiveRecord::Migration[6.1]
  def change
    add_column :plates, :imageurls, :string, array: true, default: []
  end
end
