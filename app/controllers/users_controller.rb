class UsersController < ApplicationContoller
  private

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
