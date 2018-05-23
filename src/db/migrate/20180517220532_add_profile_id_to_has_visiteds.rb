class AddProfileIdToHasVisiteds < ActiveRecord::Migration[5.2]
  def change
    add_column :has_visiteds, :profile_id, :integer
  end
end
