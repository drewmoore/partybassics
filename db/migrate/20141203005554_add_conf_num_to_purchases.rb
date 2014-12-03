class AddConfNumToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :conf_num, :integer
  end
end
