class ContactsController < ApplicationController
  def create
    pre = Contact.find_by(email: contact_params[:email])
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
    pre = Contact.find_by(email: contact_params[:email])
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
    @num_fb = 0
    @fb_female = 0
    @fb_male = 0
    @num_paying = 0
    num_paying_gender_data = 0
    @num_paying_female = 0
    @num_paying_male = 0
    @num_tickets_female = 0
    @num_tickets_male = 0
    contacts.each do |c|
      if c.facebook_id.empty?
        @num_email += 1
      else
        @num_fb += 1
        if c.gender === "male"
          @fb_male += 1
        elsif c.gender === "female"
          @fb_female += 1
        end
      end
      if c.tickets_purchased > 0
        @num_paying += 1
        if c.gender === "male"
          @num_paying_male += 1
          @num_tickets_male += c.tickets_purchased.to_i
          num_paying_gender_data += 1
        elsif c.gender === "female"
          @num_paying_female += 1
          @num_tickets_female += c.tickets_purchased.to_i
          num_paying_gender_data += 1
        end
      end
    end
    @num_purchases = Purchase.all.length
    @num_tickets = 0
    @total_sales = 0
    Purchase.all.each do |p|
      @num_tickets += p.quantity.to_i
      @total_sales += (p.amount.to_f / 100.0)
    end
    @avg_tickets_per_purchase = avg(@num_tickets, @num_purchases)
    @avg_tickets_per_paying = avg(@num_tickets, @num_paying)
    @avg_tickets_per_female = avg((@num_tickets_male + @num_tickets_female), @num_paying_female)
    @avg_tickets_per_male = avg((@num_tickets_male + @num_tickets_female), @num_paying_male)
    ticketed_events = Event.all.where("ticket_limit > 0")
    @num_events = ticketed_events.length
    @avg_tickets_per_event = avg(@num_tickets, @num_events)
    ticket_percentage_total = 0
    ticketed_events.each do |e|
      ticket_percentage_total += percent(e.tickets_sold, e.ticket_limit)
    end
    @avg_percentage_tickets_per_event = avg(ticket_percentage_total, @num_events)
    @avg_sales_per_event = avg(@total_sales, @num_events)

    @percent_paying_gender_data = percent(num_paying_gender_data, @num_paying)
    @percent_unique_visitors_of_total = percent(@unique_visitors, @total_visits)
    @percent_contacts_of_uniques = percent(@num_contacts, @unique_visitors)
    @percent_fb_of_uniques = percent(@num_fb, @unique_visitors)
    @percent_fb_of_contacts = percent(@num_fb, @num_contacts)
    @percent_female_of_fb = percent(@fb_female, @num_fb)
    @percent_male_of_fb = percent(@fb_male, @num_fb)
    @percent_purchases_of_visits = percent(@num_purchases, @total_visits)

  end

  private

  def contact_params
    params.require(:contact).permit(:email, :facebook_id, :facebook_link, :gender, :first_name, :last_name, :full_name, :unsubscribed, :visitor_id)
  end
end
