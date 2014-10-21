class AddPageIdToContent < ActiveRecord::Migration
  def change
    add_column :contents, :page_id, :integer
  end
end
