class RemovePageIdFromContents < ActiveRecord::Migration
  def change
    remove_column :contents, :page_id
  end
end
