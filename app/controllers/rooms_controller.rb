class RoomsController < ApplicationController
  def index
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    user_ids = params[:room][:user_ids].split(',').map(&:to_i) # 文字列から整数に変換
    selected_users = User.where(id: user_ids).to_a
  
    # current_user を選択されたユーザーに追加
    selected_users << current_user
  
    if @room.save
      # 選択されたユーザーをチャットルームのメンバーに追加
      @room.users = selected_users  # ここで users リレーションを上書き
  
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to root_path
  end

  private

  def room_params
    params.require(:room).permit(:name, user_ids: [])
  end

end
