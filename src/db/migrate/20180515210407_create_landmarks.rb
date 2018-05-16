class CreateLandmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :landmarks do |t|
      t.string :description
      t.string :name
      t.decimal :latitude
      t.decimal :longitude 

      t.timestamps
    end
  end
end
