class CreateJoinTableContactVisitor < ActiveRecord::Migration
  def change
    create_join_table :contacts, :visitors do |t|
      # t.index [:contact_id, :visitor_id]
      # t.index [:visitor_id, :contact_id]
    end
  end
end
