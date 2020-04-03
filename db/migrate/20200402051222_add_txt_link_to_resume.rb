class AddTxtLinkToResume < ActiveRecord::Migration[6.0]
  def change
    add_column :resumes, :s3_txt_link, :string
  end
end
