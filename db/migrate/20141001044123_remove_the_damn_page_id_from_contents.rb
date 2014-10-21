class RemoveTheDamnPageIdFromContents < ActiveRecord::Migration
  def change
    remove_column :contents, :page_id
  end
end
