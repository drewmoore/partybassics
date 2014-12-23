class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.string :ip
      t.integer :visits, default: 1

      t.timestamps
    end
  end
end
