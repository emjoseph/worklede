class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :url
      t.text :desc
      t.string :location
      t.string :title
      t.string :code
      t.string :company
      t.string :platform
      t.string :category
      t.string :posted_days_ago_string
      t.integer :posted_days_ago_int
      t.timestamps
    end
    add_index :jobs, [:code, :company], unique: true
  end
end
