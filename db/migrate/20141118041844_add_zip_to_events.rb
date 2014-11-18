class AddZipToEvents < ActiveRecord::Migration
  def change
    add_column :events, :zip, :string
  end
end
