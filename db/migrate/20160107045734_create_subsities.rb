class CreateSubsities < ActiveRecord::Migration
  def change
    create_table :subsities do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
