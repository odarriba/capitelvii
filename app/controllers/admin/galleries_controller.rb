class Admin::GalleriesController < Admin::BaseController
  before_action :load_gallery, only: [:edit, :update, :destroy]

  def index
    page = params[:page].to_i unless (params[:page].blank? || params[:page].to_i < 1)
    page ||= 1

    max_page = (Gallery.count*1.0/Gallery.default_per_page).ceil
    max_page = 1 if (max_page == 0)

    page = max_page if (page > max_page)

    # Paginate results
    @galleries = Gallery.page(page)

    respond_to do |format|
      format.html
    end
  end

  def new
    @gallery = Gallery.new

    @gallery.pictures.build

    respond_to do |format|
      format.html
    end
  end

  def create
    @gallery = Gallery.new(gallery_params)

    respond_to do |format|
      format.html {
        if (@gallery.save)
          flash[:notice] = t(".success", title: @gallery.title)
          redirect_to action: :index
        else
          flash[:error] = t(".error")
          @gallery.pictures.build

          render action: :new
        end
      }
    end
  end

  def edit
    return if @gallery.blank?

    @gallery.pictures.build

    respond_to do |format|
      format.html
    end
  end

  def update
    return if @gallery.blank?

    respond_to do |format|
      format.html {
        if (@gallery.update_attributes(gallery_params))
          flash[:notice] = t(".success", title: @gallery.title)
          redirect_to action: :index
        else
          flash[:error] = t(".error")
          @gallery.pictures.build

          render action: :edit
        end
      }
    end
  end

  def destroy
    return if @gallery.blank?

    if (@gallery.destroy)
      flash[:notice] = t(".success", title: @gallery.title)
    else
      flash[:error] = t(".error", title: @gallery.title)
    end

    respond_to do |format|
      format.html { redirect_to action: :index }
    end
  end

  protected

  # Function to load existing gallery based on ID received in params.
  #
  def load_gallery
    @gallery = Gallery.where(id: params[:id]).first

    if (@gallery.blank?)
      flash[:error] = t("admin.galleries.not_found")
      redirect_to action: :index
    end
  end

  # Strong Parameters for Gallery objects.
  #
  def gallery_params
    params.require(:gallery).permit(:title, :description, :slug, :position, :draft, :seo_title, :seo_description, :seo_tags, :pictures_attributes => [:description, :id, :file, :file_cache, :_destroy])
  end
end
