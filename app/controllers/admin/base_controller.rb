class Admin::BaseController < ApplicationController
  before_action :authenticate_user!

  layout "admin"

  def index
    respond_to do |format|
      format.html
    end
  end
end
