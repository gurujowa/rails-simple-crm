class CreateLeadComment < ActiveRecord::Migration
  def change
    create_table :lead_comments do |t|
      t.references :lead, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false
      t.text :memo, null: false
      t.timestamps  null: false
    end
  end
end
