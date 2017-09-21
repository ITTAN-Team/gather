class CreateEventImages < ActiveRecord::Migration[5.0]
  def change
    create_table :event_images do |t|
      t.boolean :main
      t.text :image_url
      t.references :event, foreign_key: true
      t.timestamps
    end
  end
end
