class MessageMailer < ActionMailer::Base
  default from: "info@shiokuritai.com"
  def received_email(message)
    @message = message
    @room = message.room
    if message.is_user
      @send_user_name = @room.user.user_name
      @received_user_name = @room.member.company.first_name + "弁護士"
    else
      @send_user_name = @room.member.company.first_name
      @received_user_name = @room.user.user_name
    end
    mail to: "info@shiokuritai.com"
    mail(subject: 'メッセージが送信されました') do |format|
      format.text
    end
  end

  def send_email(message)
    @message = message
    @room = message.room
    if message.is_user
      @send_user_name = @room.user.user_name
      @received_user_email = @room.member.company.mail
    else
      @send_user_name = @room.member.company.first_name + "弁護士"
      @received_user_email = @room.user.email
    end
    mail to: @received_user_email
    mail(subject: 'メッセージが届いています') do |format|
      format.text
    end
  end
end
