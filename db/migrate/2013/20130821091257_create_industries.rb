class CreateIndustries < ActiveRecord::Migration
  def change
    create_table :industries do |t|
      t.string :name

      t.timestamps
    end
    
    Industry.create(:name => "介護")
    Industry.create(:name => "保育")
    Industry.create(:name => "IT")
    Industry.create(:name => "歯科")

  end
end
