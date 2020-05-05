class UsersController < ApplicationController
  before_action :load_user, except: %i(new create)
  before_action :authenticate_user!, only: %i(edit update)
  before_action :correct_user, only: %i(edit update)

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "app.sign_up.welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "app.users.profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :phone, :address
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to :root unless current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user.present?
    flash[:danger] = t "app.users.not_found"
    redirect_to signup_path
  end
end
