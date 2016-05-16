class Admin::GalleriesController < Admin::BaseController
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
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
