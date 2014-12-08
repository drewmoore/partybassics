class AddContentIdToPages < ActiveRecord::Migration
  def change
    add_column :pages, :content_id, :integer
  end
end
