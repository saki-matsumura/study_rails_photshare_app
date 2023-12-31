class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
  end

  def edit
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user), notice: "勝手に書き換えようとしないでくださ〜い！"
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: "ユーザー情報を編集しました！"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,
                                 :icon, :icon_cache)
  end
  
  def set_user
    @user = User.find(params[:id])
  end

end
