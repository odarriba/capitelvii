class Admin::UsersController < Admin::BaseController
  before_action :load_user, only: [:edit, :update, :destroy]

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
    @user = User.new(user_params)

    respond_to do |format|
      format.html {
        if (@user.save)
          flash[:notice] = t(".message.created", email: @user.email)
          redirect_to action: :index
        else
          flash[:error] = t(".error.not_created")
          render action. :new
        end
      }
    end
  end

  def edit
    return if @user.blank?

    respond_to do |format|
      format.html
    end
  end

  def update
    return if @user.blank?

    respond_to do |format|
      format.html {
        if (@user.update_attributes(user_params))
          flash[:notice] = t(".message.updated", email: @user.email)
          redirect_to action: :index
        else
          flash[:error] = t(".error.not_updated")
          render action: :edit
        end
      }
    end
  end

  def destroy
    return if @user.blank?

    if (@user.destroy)
      flash[:notice] = t(".message.destroyed", email: @user.email)
    else
      flash[:error] = t(".error.not_destroyed", email: @user.email)
    end

    respond_to do |format|
      format.html { redirect_to action: :index }
    end
  end

  protected

  # Function to load existing user based on ID received in params.
  #
  def load_user
    @user = User.where(id: params[:id]).first

    if (@user.blank?)
      flash[:error] = t(".errors.not_found")
      redirect_to action: :index
    end
  end

  # Strong Parameters
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
