class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.belongs_to :user, null: false
      t.belongs_to :listing, null: false
      t.timestamps null: false
      t.string :comments
      t.integer :guests
      t.datetime :check_in_date
      t.datetime :check_out_date
      t.boolean :smoking
      t.boolean :pets 
      t.boolean :kitchen
      t.boolean :tv
      t.boolean :internet
      t.boolean :wifi
      t.boolean :free_parking 
      t.boolean :family_friendly
      t.boolean :suitable_events   
    end

  add_index :reservations, :user_id
  add_index :reservations, :listing_id    
  add_index :reservations, :check_in_date
  add_index :reservations, :check_out_date
  end
end