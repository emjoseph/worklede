class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.references :resume, null: false, foreign_key:true, index: true
      t.references :job, null: false, index: true
      t.boolean :didEmail
      t.boolean :didEmail2
      t.string :company
      t.timestamps
    end
  end
end
