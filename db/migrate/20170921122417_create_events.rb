class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name, limit: 255
      t.string :real_name, limit: 255
      t.text :description
      t.text :location_url
      t.text :address
      t.text :link
      t.text :capacity, limit: 255
      t.integer :group_id
      t.timestamps
    end
  end
end
