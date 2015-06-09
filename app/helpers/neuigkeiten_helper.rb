module NeuigkeitenHelper # :nodoc:
  def send_daily_newsletter(user)
    NewsMailer.daily_newsletter(user.id).deliver
  end
end
