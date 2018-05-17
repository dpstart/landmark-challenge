class AddLandmarkIdToHasVisiteds < ActiveRecord::Migration[5.2]
  def change
    add_column :has_visiteds, :landmark_id, :integer
  end
end
