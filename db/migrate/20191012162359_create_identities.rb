class CreateIdentities < ActiveRecord::Migration[5.2]
  def change
    create_table :identities do |t|
      t.string :provider
      t.integer :uid
      t.references :user, foreign_key: true
      t.string :username
      t.string :image_url

      t.timestamps
    end
  end
end
