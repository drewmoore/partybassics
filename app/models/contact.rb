class Contact < ActiveRecord::Base
  validates_uniqueness_of :email, :if => '!email.empty?'
  validates_uniqueness_of :facebook_id, :if => '!facebook_id.empty?'
  has_and_belongs_to_many :visitors, :join_table => :contacts_visitors

  def add_visitor visitor
    if self.visitors.length > 0
      if self.visitors.exists? visitor
        return
      else
        self.visitors << visitor
      end
    else
      self.visitors << visitor
    end
  end
end
