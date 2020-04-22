class CreateResumes < ActiveRecord::Migration[6.0]
  def change
    create_table :resumes do |t|
      t.string :s3_link
      t.string :name
      t.references :user, null: false, foreign_key:true, on_delete: :cascade
      t.timestamps
    end
  end
end
