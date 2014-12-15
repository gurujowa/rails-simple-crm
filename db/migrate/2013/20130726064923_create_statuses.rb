class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :name
      t.string :rank
      t.boolean :active

      t.timestamps
    end
  end
end
