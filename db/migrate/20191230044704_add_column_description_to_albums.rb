class AddColumnDescriptionToAlbums < ActiveRecord::Migration[6.0]
  def change
    add_column :albums, :description, :text
  end
end
