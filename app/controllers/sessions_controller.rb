class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      reset_session # セッション固定攻撃対策
      log_in user #ユーザー情報をセッションに保存
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity #失敗時
    end
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end
end
