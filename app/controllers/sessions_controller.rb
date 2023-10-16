class SessionsController < ApplicationController
    def new
    end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:sessions][:password])
      # ログイン成功

    else
      # ログイン失敗
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
end
