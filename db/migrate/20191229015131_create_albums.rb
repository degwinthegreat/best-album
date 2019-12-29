class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.integer :rank
      t.text    :url
      t.string  :title
      t.string  :posted_by
      t.timestamps
    end
  end
end
