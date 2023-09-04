class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])

    @messages = if params[:category_id].present? && params[:category_id] != ''
                  @room.messages.where(category_id: params[:category_id]).includes(:user)
                else
                  @room.messages.includes(:user)
                end
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user)
      render :index, status: :unprocessable_entity
    end

    respond_to do |format|
      format.html # 通常のHTMLレスポンス
      format.json { render json: @messages } # JSONレスポンス
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :category_id, images: []).merge(user_id: current_user.id)
  end
end
