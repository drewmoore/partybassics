class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :email, default: ""
      t.string :facebook_id, default: ""
      t.string :facebook_link, default: ""
      t.string :gender, default: ""
      t.integer :tickets_purchased, default: 0
      t.string :first_name, default: ""
      t.string :last_name, default: ""
      t.string :full_name, default: ""
      t.boolean :unsubscribed, default: false

      t.timestamps
    end
  end
end
