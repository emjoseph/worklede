class AddResumeTxtToResume < ActiveRecord::Migration[6.0]
  def change
    add_column :resumes, :resume_txt, :text
  end
end
