class AddPathToGraphics < ActiveRecord::Migration
  def change
    add_column :graphics, :path, :string
  end
end
