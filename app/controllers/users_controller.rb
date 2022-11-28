class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:top]
   before_action :configure_permitted_parameters, if: :devise_controller?

  def new
  end

  def edit
    @user = User.find(params[:id])
    user_id = params[:id].to_i
  login_user_id = current_user.id
  if(user_id != login_user_id)
    redirect_to user_path(current_user.id)
  end

  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def index
    @users = User.all
  end

  def update
    user_id = params[:id].to_i
  login_user_id = current_user.id
  if(user_id != login_user_id)
    redirect_to books_path
  end
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'You have updated user successfully.'
    redirect_to user_path(@user.id)
    else
    @users = User.all
    render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
