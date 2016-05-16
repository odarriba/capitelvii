class ContactRequestsController < ApplicationController
  before_action :load_page

  # Action to get the form of a new contact request
  #
  def new
    @contact_request = ContactRequest.new()

    respond_to do |format|
      format.html
    end
  end

  # Action to create a new contact request
  #
  def create
    # Avoid duplicates
    @contact_request = ContactRequest.find_or_initialize_by(contact_request_params)

    respond_to do |format|
      format.html {
        if (@contact_request.save)
          flash[:notice] = t(".saved")
          redirect_to action: :new
        else
          flash[:error] = t(".error")
          render action: :new
        end
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
  def contact_request_params
    params.require(:contact_request).permit(:name, :email, :phone, :body)
  end
end
