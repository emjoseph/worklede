class AddJobToMatchAssociation < ActiveRecord::Migration[6.0]
  def change
    add_reference :jobs, :match, index: true, foreign_key: true, on_delete: :cascade
  end
end
