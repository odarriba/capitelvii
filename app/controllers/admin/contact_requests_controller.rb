class Admin::ContactRequestsController < Admin::BaseController
  before_action :load_contact_request, only: [:show, :destroy]

  # Action to list registered contact requests
  #
  def index
    page = params[:page].to_i unless (params[:page].blank? || params[:page].to_i < 1)
    page ||= 1

    max_page = (ContactRequest.count*1.0/ContactRequest.default_per_page).ceil
    max_page = 1 if (max_page == 0)

    page = max_page if (page > max_page)

    # Paginate results
    @contact_requests = ContactRequest.page(page)

    respond_to do |format|
      format.html
    end
  end

  # Action to show a contact request
  #
  def show
    return if @contact_request.blank?

    respond_to do |format|
      format.html
    end
  end

  # Action to destroy a contact request
  #
  def destroy
    return if @contact_request.blank?

    if (@contact_request.destroy)
      flash[:notice] = t(".success", title: @contact_request.name)
    else
      flash[:error] = t(".error", title: @contact_request.name)
    end

    respond_to do |format|
      format.html { redirect_to action: :index }
    end
  end

  protected

  # Before action filter to load the contact request from the DB.
  # If no record is found, redirect to index with an error.
  #
  def load_contact_request
    @contact_request = ContactRequest.where(id: params[:id]).first

    if (@contact_request.blank?)
      flash[:error] = t("admin.contact_requests.not_found")
      redirect_to action: :index
    end
  end
end
