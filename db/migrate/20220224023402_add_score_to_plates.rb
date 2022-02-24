class AddScoreToPlates < ActiveRecord::Migration[6.1]
  def change
    add_column :plates, :score, :integer
  end
end
