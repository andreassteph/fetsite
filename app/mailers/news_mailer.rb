class NewsMailer < ActionMailer::Base
  default from: "salzamt@fet.at"
  def neuigkeit_mail(email, neuigkeit_id)
    @neuigkeit= Neuigkeit.find(neuigkeit_id)
    
    mail(to: email, subject: @neuigkeit.title)
  end
end
