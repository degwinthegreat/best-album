class AddColumnImageToAlbum < ActiveRecord::Migration[6.0]
  def change
    add_column :albums, :image, :text
  end
end
