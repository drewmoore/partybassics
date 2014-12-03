class AddTicketLimitToEvents < ActiveRecord::Migration
  def change
    add_column :events, :ticket_limit, :string
  end
end
