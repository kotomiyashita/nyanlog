class UsersController < ApplicationController

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def search
    search_term = params[:search]

    # ユーザー名での検索を実行
    @users = User.where("name LIKE ?", "%#{search_term}%")

    respond_to do |format|
      format.html # HTMLレスポンスを返す場合の処理
      format.json { render json: @users } # JSONレスポンスを返す場合の処理
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

end
