class ChangeEventsTicketLimitToInteger < ActiveRecord::Migration
  def change
    change_column :events, :ticket_limit, 'integer USING CAST(ticket_limit AS integer)'
  end
end
