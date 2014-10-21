class CreateJoinTableContentPage < ActiveRecord::Migration
  def change
    create_join_table :contents, :pages
  end
end
