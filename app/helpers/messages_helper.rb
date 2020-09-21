module MessagesHelper
  def show_time(message)
    message.n_days_ago?(4) ? ("#{time_ago_in_words(message.created_at)}".match(/以内/)? "#{time_ago_in_words(message.created_at)}" : "#{time_ago_in_words(message.created_at)}前") : "#{message.created_at.strftime("%-Y年%-m月%-d日 %-H時%-M分")}"
  end

  def show_content(message)
    safe_join(message.content.split("\n"),tag(:br))
  end
end
