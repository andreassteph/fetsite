class NewsMailer < ActionMailer::Base
  default from: "salzamt@fet.at"
  def neuigkeit_mail(email, neuigkeit_id)
    @neuigkeit= Neuigkeit.find(neuigkeit_id)
    mail(to: "andis@fet.at", subject: @neuigkeit.title)
  end
end
