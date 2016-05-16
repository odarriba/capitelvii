class Admin::ContactsController < Admin::BaseController
  before_action :load_contact, only: [:show, :destroy]

  # Action to list registered contact requests
  #
  def index
    page = params[:page].to_i unless (params[:page].blank? || params[:page].to_i < 1)
    page ||= 1

    max_page = (Contact.count*1.0/Contact.default_per_page).ceil
    max_page = 1 if (max_page == 0)

    page = max_page if (page > max_page)

    # Paginate results
    @pages = Contact.page(page)

    respond_to do |format|
      format.html
    end
  end

  # Action to show a contact request
  #
  def show
    return if @contact.blank?

    respond_to do |format|
      format.html
    end
  end

  # Action to destroy a contact request
  #
  def destroy
    return if @contact.blank?

    if (@contact.destroy)
      flash[:notice] = t(".success", title: @contact.name)
    else
      flash[:error] = t(".error", title: @contact.name)
    end

    respond_to do |format|
      format.html { redirect_to action: :index }
    end
  end

  protected

  # Before action filter to load the contact request from the DB.
  # If no record is found, redirect to index with an error.
  #
  def load_contact
    @contact = Contact.where(id: params[:id]).first

    if (@contact.blank?)
      flash[:error] = t("admin.contacts.not_found")
      redirect_to action: :index
    end
  end
end
