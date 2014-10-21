class AddControllerToPages < ActiveRecord::Migration
  def change
    add_column :pages, :controller, :string
  end
end
