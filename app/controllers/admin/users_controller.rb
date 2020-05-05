class Admin::UsersController < Admin::BaseController
  before_action :load_user, except: %i(new index create)

  def index
    params = search_params ? search_params[:name] : nil
    @pagy, @users = pagy(User.show_user.show_user_desc
      .search_user(params), items: Settings.page.page_number_admin)
  end

  def new
    @user = User.new
  end

  def show
    respond_to do |format|
      format.js
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "create_success"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "update_success"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    begin
      @user.destroy
      flash[:success] = t "delete_success"
    rescue
      flash[:danger] = t "not_delete"
    end
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit :name,:email, :phone, :address, :is_admin,
      :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user.present?
    flash[:danger] = t "not_user"
    redirect_to root_path
  end

  def search_params
    return nil unless params[:user_list]
    params.require(:user_list).permit :name
  end
end
