class GalleriesController < ApplicationController
  before_action :load_page
  before_action :load_gallery

  def show
    return if @gallery.blank?

    respond_to do |format|
      format.html
    end
  end

  protected

  def load_page
    @page = Page.find_or_initialize_by(slug: 'nuestros-trabajos')
  end

  def load_gallery
    raise ActiveRecord::RecordNotFound if Gallery.published.blank?

    if (params[:slug].blank?)
      redirect_to gallery_path(slug: Gallery.published.first.slug)
    else
      @gallery = Gallery.find(params[:slug])
    end
  end
end
