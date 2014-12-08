class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :amount
      t.string :quantity
      t.string :email
      t.string :lastfour

      t.timestamps
    end
  end
end
