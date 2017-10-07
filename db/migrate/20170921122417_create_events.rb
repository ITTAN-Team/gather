class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name, limit: 255
      t.text :description
      t.text :location_url
      t.text :address
      t.text :link
      t.text :image
      t.integer :capacity
      t.integer :group_id
      t.timestamp :event_date
      t.timestamps
    end
  end
end
