class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.belongs_to :user, index: true
      t.string :title, null: false
      t.string :location, null: false
      t.timestamps null: false
      t.string :about
      t.integer :accomodates
      t.integer :bathrooms
      t.string :bed_type
      t.integer :bedrooms
      t.integer :beds 
      t.datetime :check_in
      t.datetime :check_out
      t.boolean :smoking
      t.boolean :pets 
      t.boolean :kitchen
      t.boolean :tv
      t.boolean :internet
      t.boolean :wifi
      t.boolean :free_parking 
      t.boolean :family_friendly
      t.boolean :suitable_events   
      t.integer :prices
      t.integer :weekly_discount
      t.integer :monthly_discount
      t.string :cancellation
      t.string :description
      t.datetime :availability_start_date
      t.datetime :availability_end_date
      t.string :safety_features
      t.string :pictures_url

    end

  add_index :listings, :title
  add_index :listings, :location
  add_index :listings, [:title, :location], unique: true     
  end
end