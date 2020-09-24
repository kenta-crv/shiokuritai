class EstimateMailer < ActionMailer::Base
  default from: "info@shiokuritai.com"
  def received_email(estimate)
    @estimate = estimate
    mail to: "info@shiokuritai.com"
    mail(subject: '士送隊より見積り依頼が届きました') do |format|
      format.text
    end
  end

  def send_email(estimate)
    @estimate = estimate
    mail to: estimate.email
    mail(subject: '弁護士一括比較見積り『士送隊』にお問い合わせ頂きありがとうございます') do |format|
      format.text
    end
  end

  def client_email(estimate)
    @estimate = estimate
    mail bcc: Company.all.map{|company| company.mail}
    mail(subject: '士送隊より見積り依頼が届きました') do |format|
      format.text
    end
  end

  def regist_user(user)
    @user = user
    mail to: @user.email
    mail(subject: '『士送隊』に会員登録頂きありがとう御座います') do |format|
      format.text
    end
  end
end
