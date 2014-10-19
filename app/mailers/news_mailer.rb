class NewsMailer < ActionMailer::Base
  default from: "salzamt@fet.at"
  def neuigkeit_mail(email, neuigkeit_id)
    @neuigkeit= Neuigkeit.find(neuigkeit_id)
    @host=request.host_with_port
    mail(to: "andis@fet.at", subject: @neuigkeit.title)
  end
end
