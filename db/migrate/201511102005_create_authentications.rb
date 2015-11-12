class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.belongs_to :user, index: true
      t.string :provider, null: false
      t.string :uid, null: false
      t.timestamps null: false
      t.string :token
      t.string :secret
      t.string :location
      t.string :image_url
      t.string :url

    end

  add_index :authentications, :provider
  add_index :authentications, :uid
  add_index :authentications, [:provider, :uid], unique: true     
  end
end