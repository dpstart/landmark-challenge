class AddCityIdToLandmarks < ActiveRecord::Migration[5.2]
  def change
    add_column :landmarks, :city_id, :integer
  end
end
