class AddTextToContents < ActiveRecord::Migration
  def change
    add_column :contents, :text, :string
  end
end
