class AddColumnEventbriteIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :eventbrite_link, :string, default: ""
  end
end
