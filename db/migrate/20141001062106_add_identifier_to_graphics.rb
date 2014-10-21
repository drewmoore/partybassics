class AddIdentifierToGraphics < ActiveRecord::Migration
  def change
    add_column :graphics, :identifier, :string
  end
end
