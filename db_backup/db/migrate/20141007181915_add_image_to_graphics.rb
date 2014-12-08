class AddImageToGraphics < ActiveRecord::Migration
  def change
    add_column :graphics, :image, :string
  end
end
