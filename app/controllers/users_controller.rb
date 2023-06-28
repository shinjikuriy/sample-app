class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "welcometo the Sample App!"
      redirect_to user_url(@user)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private
    #paramsに必須パラメータと許可パラメータを与える
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end
