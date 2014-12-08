class DropJoinTableEventPurchase < ActiveRecord::Migration
  def change
    drop_join_table :events, :purchases do |t|
      # t.index [:event_id, :purchase_id]
      # t.index [:purchase_id, :event_id]
    end
  end
end
