class PagesController < ApplicationController
  def show
    @page = Page.find(params['slug'])

    respond_to do |format|
      format.html
    end
  end
end
