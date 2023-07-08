class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password])
      if @user.activated?
        forwarding_url = session[:forwarding_url] #セッションリセット前に取り出し
        reset_session # セッション固定攻撃対策
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        log_in @user #ユーザー情報をセッションに保存
        redirect_to forwarding_url || @user
      else
        message = "Account not activated. "
        message += "Check your email for the activatioin link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity #失敗時
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end
end
