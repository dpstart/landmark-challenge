class AddAchievementIdToHasEarneds < ActiveRecord::Migration[5.2]
  def change
    add_column :has_earneds, :achievement, :integer
  end
end
