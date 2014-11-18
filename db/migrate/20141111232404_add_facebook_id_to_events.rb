class AddFacebookIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :facebook_id, :string
  end
end
