class MessagesController < ApplicationController
  before_action :redirect_room_invalid_user, only: :room

  def room
    room = Room.find_by(uri_token: params[:uri_token])
    @messages = room.messages
    @member = room.member
    @user = room.user
  end

  private
    def redirect_room_invalid_user
      room =  Room.find_by(uri_token: params[:uri_token])
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
