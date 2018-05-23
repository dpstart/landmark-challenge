class AddProfileIdToHasEarneds < ActiveRecord::Migration[5.2]
  def change
    add_column :has_earneds, :profile_id, :integer
  end
end
