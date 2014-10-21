class RemoveContentIdFromPages < ActiveRecord::Migration
  def change
    remove_column :pages, :content_id
  end
end
