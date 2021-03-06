class Admin::UsersController < Admin::BaseController
  before_action :load_user, only: [:edit, :update, :destroy]

  def index
    page = params[:page].to_i unless (params[:page].blank? || params[:page].to_i < 1)
    page ||= 1

    max_page = (User.count*1.0/User.default_per_page).ceil
    max_page = 1 if (max_page == 0)

    page = max_page if (page > max_page)

    # Paginate results
    @users = User.page(page)

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
          flash[:notice] = t(".success", email: @user.email)
          redirect_to action: :index
        else
          flash[:error] = t(".error")
          render action: :new
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

    user_data = user_params

    if (user_data[:password].blank? && user_data[:password_confirmation].blank?)
      user_data.delete(:password)
      user_data.delete(:password_confirmation)
    end

    respond_to do |format|
      format.html {
        if (@user.update_attributes(user_data))
          flash[:notice] = t(".success", email: @user.email)
          redirect_to action: :index
        else
          flash[:error] = t(".error")
          render action: :edit
        end
      }
    end
  end

  def destroy
    return if @user.blank?

    if (@user.destroy)
      flash[:notice] = t(".success", email: @user.email)
    else
      flash[:error] = t(".error", email: @user.email)
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
      flash[:error] = t("admin.users.not_found")
      redirect_to action: :index
    end
  end

  # Strong Parameters
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
