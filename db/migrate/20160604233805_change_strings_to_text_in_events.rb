class ChangeStringsToTextInEvents < ActiveRecord::Migration
  def up
    change_column :events, :description,     :text, :limit => nil
    change_column :events, :eventbrite_link, :text, :limit => nil
  end

  def down
    change_column :events, :description,     :string
    change_column :events, :eventbrite_link, :string
  end
end
