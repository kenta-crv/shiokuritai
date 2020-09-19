class MessagesController < ApplicationController
  def room
    @room = Room.find_by(uri_token: params[:uri_token])
    redirect_invalid_user(@room)
    @messages = @room.messages
    @member = @room.member
    @user = @room.user
    # 既読にする
    @read_user = current_user.present? ? current_user : current_member
    Message.read(@room, @read_user)

    @message = Message.new
  end

  def create
    @room =  Room.find_by(params[:id])
    redirect_invalid_user(@room)
    @message = Message.new(message_params)

    if @message.save
      redirect_to room_messages_path(uri_token: @room.uri_token), alert: "メッセージを送信しました"
    else
      @messages = @room.messages
      @member = @room.member
      @user = @room.user
      render :room
    end
  end

  private
    def message_params
      params.require(:message).permit(:content, :room_id, :is_user)
    end

    def redirect_invalid_user(room)
      return render_404 if room.blank? || !room.active?

      member = room.member
      user = room.user
      # メンバーでもユーザーでもない時
      if current_member.blank? && current_user.blank?
        return render_404
      end
      # 違うメンバーの時
      if current_member.present? && current_member != member
        return render_404
      end
      # 違うユーザーの時
      if current_user.present? && current_user != user
        return render_404
      end
    end
end
