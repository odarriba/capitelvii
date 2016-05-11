class Admin::UsersController < Admin::BaseController
  before_action :load_user

  def index
    @user = User.all

    respond_to do |format|
      format.html
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html
    end
  end

  def create

  end

  def edit
    return if @user.blank?

    respond_to do |format|
      format.html
    end
  end

  def update
    return if @user.blank?
  end

  def destroy
    return if @user.blank?

    if (@user.destroy)
      flash[:notice] = t(".messages.destroyed")
    else
      flash[:error] = t(".error.not_destroyed")
    end

    respond_to do |format|
      format.html { redirect_to action: :index }
    end
  end

  protected

  def load_user
    @user = User.where(id: params[:id]).first

    if (@user.blank?)
      flash[:error] = t(".errors.not_found")
      redirect_to action: :index
    end
  end
end
