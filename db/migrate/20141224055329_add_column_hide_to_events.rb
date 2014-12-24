class AddColumnHideToEvents < ActiveRecord::Migration
  def change
    add_column :events, :hide, :boolean, default: false
  end
end
