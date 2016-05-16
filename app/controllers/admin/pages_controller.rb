class Admin::PagesController < Admin::BaseController
  before_action :load_page, only: [:edit, :update, :destroy]

  def index
    page = params[:page].to_i unless (params[:page].blank? || params[:page].to_i < 1)
    page ||= 1

    max_page = (Page.count*1.0/Page.default_per_page).ceil
    max_page = 1 if (max_page == 0)

    page = max_page if (page > max_page)

    # Paginate results
    @pages = Page.page(page)

    respond_to do |format|
      format.html
    end
  end

  def new
    @page = Page.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @page = Page.new(page_params)

    respond_to do |format|
      format.html {
        if (@page.save)
          flash[:notice] = t(".success", title: @page.title)
          redirect_to action: :index
        else
          flash[:error] = t(".error")
          render action: :new
        end
      }
    end
  end

  def edit
    return if @page.blank?

    respond_to do |format|
      format.html
    end
  end

  def update
    return if @page.blank?

    respond_to do |format|
      format.html {
        if (@page.update_attributes(page_params))
          flash[:notice] = t(".success", title: @page.title)
          redirect_to action: :index
        else
          flash[:error] = t(".error")
          render action: :edit
        end
      }
    end
  end

  def destroy
    return if @page.blank?

    if (@page.destroy)
      flash[:notice] = t(".success", title: @page.title)
    else
      flash[:error] = t(".error", title: @page.title)
    end

    respond_to do |format|
      format.html { redirect_to action: :index }
    end
  end

  protected

  # Function to load existing page based on ID received in params.
  #
  def load_page
    @page = Page.where(id: params[:id]).first

    if (@page.blank?)
      flash[:error] = t("admin.pages.not_found")
      redirect_to action: :index
    end
  end

  # Strong Parameters
  def page_params
    params.require(:page).permit(:title, :subtitle, :slug, :body, :order, :show_in_menu, :draft)
  end
end
