class ContactsController < ApplicationController
  def create
    pre = Contact.find_by("email LIKE ?", contact_params[:email])
    if pre
      pre.update_attributes(contact_params)
    else
      @contact = Contact.new(contact_params)
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
  end

  def unsubscribe
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    @contact.update_attributes(contact_params)
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :facebook_id, :facebook_link, :gender, :first_name, :last_name, :full_name, :unsubscribed)
  end
end
