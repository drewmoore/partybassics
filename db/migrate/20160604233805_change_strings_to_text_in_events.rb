class ChangeStringsToTextInEvents < ActiveRecord::Migration
  def up
    change_column :events, :description,     :text
    change_column :events, :eventbrite_link, :text
  end

  def down
    change_column :events, :description,     :string
    change_column :events, :eventbrite_link, :string
  end
end
