class AddCoordinatesToCitys < ActiveRecord::Migration[5.2]
  def change
    add_column :cities, :latitude, :decimal, {:precision=>10, :scale=>6}
    add_column :cities, :longitude, :decimal, {:precision=>10, :scale=>6}
  end
end
