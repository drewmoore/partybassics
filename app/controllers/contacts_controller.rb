class ContactsController < ApplicationController
  def create
    @contact = Contact.create(contact_params)
    render nothing:true
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :facebook_id, :facebook_link, :gender, :first_name, :last_name, :full_name)
  end
end
