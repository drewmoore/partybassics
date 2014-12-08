class AddActionToPages < ActiveRecord::Migration
  def change
    add_column :pages, :action, :string
  end
end
