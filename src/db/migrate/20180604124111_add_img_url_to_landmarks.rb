class AddImgUrlToLandmarks < ActiveRecord::Migration[5.2]
  def change
    add_column :landmarks, :img_URL, :string
  end
end
