class Admins::UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.order(updated_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    @user.skip_reconfirmation!
    if @user.update(user_params)
      redirect_to admins_user_path, notice: '会員情報を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!

    redirect_to admins_users_path, status: :see_other, notice: '会員情報を削除しました'
  end

  private

  def set_user
    @user = User.find(params.expect(:id))
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
