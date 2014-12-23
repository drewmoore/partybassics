class AddContactToVisitor < ActiveRecord::Migration
  def change
    add_reference :visitors, :contact, index: true
  end
end
