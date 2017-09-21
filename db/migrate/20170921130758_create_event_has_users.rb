class CreateEventHasUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :event_has_users do |t|
      t.references  :event, foreign_key: true
      t.references  :user, foreign_key: true
      t.timestamps
    end
  end
end
