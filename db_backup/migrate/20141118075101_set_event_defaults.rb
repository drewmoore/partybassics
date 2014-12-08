class SetEventDefaults < ActiveRecord::Migration
  def change
    change_column :events, :description, :string, default: ""
  end
end
