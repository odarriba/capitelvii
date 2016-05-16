class ContactsController < ApplicationController
  before_action :load_page

  # Action to get the form of a new contact request
  #
  def new
    @contact = Contact.new()

    respond_to do |format|
      format.html
    end
  end

  # Action to create a new contact request
  #
  def create
    # Avoid duplicates
    @contact = Contact.find_or_initialize_by(contact_params)

    respond_to do |format|
      format.html {
        if (@contact.save)
          flash[:notice] = t(".saved")
        else
          flash[:error] = t(".error")
        end
        render action: :new
      }
    end
  end

  protected

  # Try to find the page with contents for the contact views
  # if not found, get a new empty object.
  #
  def load_page
    @page = Page.find_or_initialize_by(slug: 'contacta') || Page.new
  end

  # Strong Paramters filter to get contact request params
  #
  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :body)
  end
end
