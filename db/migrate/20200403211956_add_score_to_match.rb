class AddScoreToMatch < ActiveRecord::Migration[6.0]
  def change
    add_column :matches, :score, :float
  end
end
