class GaysMailer < ActionMailer::Base
  default from: "anal_punisher@taganteam.com"

  def auto_debit_score address_to, title, body
    @body, @title = body, title
    mail(to: address_to, subject: 'Кажется ты получил минус в ЗП...')
  end

end