class CreateLandmarks < ActiveRecord::Migration[5.2]
  def change
    change_column :landmarks, :latitude, :decimal, {:precision=>10, :scale=>6}
    change_column :landmarks, :longitude, :decimal, {:precision=>10, :scale=>6}
  end
end
