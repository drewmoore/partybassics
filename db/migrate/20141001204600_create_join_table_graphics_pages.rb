class CreateJoinTableGraphicsPages < ActiveRecord::Migration
  def change
    create_join_table :graphics, :pages
  end
end
