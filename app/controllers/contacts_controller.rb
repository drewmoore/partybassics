class ContactsController < ApplicationController
  def create
    pre = Contact.find_by("email LIKE ?", contact_params[:email])
    visitor = Visitor.find(contact_params[:visitor_id])
    if pre
      if visitor and !pre.visitors.exists? visitor
        pre.visitors << visitor
        pre.save
      end
      pre.update_attributes(contact_params.except(:visitor_id))
    else
      @contact = Contact.new(contact_params.except(:visitor_id))
      if visitor
        @contact.visitors << visitor
      end
      @contact.save
    end
    render nothing:true
  end

  def subscribe
    @contact = Contact.new
  end

  def subscribe_this
    @email = contact_params[:email]
    pre = Contact.find_by("email LIKE ?", contact_params[:email])
    if pre
      attribute = {unsubscribed: false}
      pre.update_attributes(attribute)
    else
      @contact = Contact.new(contact_params)
      @contact.save
    end
    set_visitor
  end

  def unsubscribe
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    @contact.update_attributes(contact_params)
  end

  def metrics
    contacts = Contact.all
    visitors = Visitor.all
    @total_visits = 0
    @unique_visitors = 0
    @unique_visitors += contacts.length
    visitors.each do |v|
      @total_visits += v.visits
      if v.contacts.length === 0
        @unique_visitors += 1
      end
    end
    @num_contacts = contacts.length
    @num_email = 0
    @num_paying = 0
    contacts.each do |c|
      if c.facebook_id.empty?
        @num_email += 1
      end
      if c.tickets_purchased > 0
        @num_paying += 1
      end
    end
    @num_purchases = Purchase.all.length

  end

  private

  def contact_params
    params.require(:contact).permit(:email, :facebook_id, :facebook_link, :gender, :first_name, :last_name, :full_name, :unsubscribed, :visitor_id)
  end
end
