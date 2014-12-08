class AddIdentifierToContents < ActiveRecord::Migration
  def change
    add_column :contents, :identifier, :string
  end
end
