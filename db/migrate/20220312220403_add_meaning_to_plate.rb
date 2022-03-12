class AddMeaningToPlate < ActiveRecord::Migration[6.1]
  def change
    add_column :plates, :meaning, :string
  end
end
