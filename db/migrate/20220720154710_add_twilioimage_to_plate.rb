class AddTwilioimageToPlate < ActiveRecord::Migration[6.1]
  def change
    add_column :plates, :twilioimage, :string
  end
end
