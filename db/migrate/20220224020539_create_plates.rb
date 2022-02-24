class CreatePlates < ActiveRecord::Migration[6.1]
  def change
    create_table :plates do |t|
      t.string :plate
      t.string :state

      t.timestamps
    end
  end
end
