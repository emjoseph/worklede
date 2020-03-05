class UserResumeAssociation < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :resumes, index: true, foreign_key: true
  end
end
