class AddFromPhoneToPlate < ActiveRecord::Migration[6.1]
  def change
    add_column :plates, :from_phone, :boolean
  end
end
