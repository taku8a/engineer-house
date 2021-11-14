class ContactMailer < ApplicationMailer
  default from: ENV['SEND_MAIL']
  
  def contact_mail(contact)
    @contact = contact
    mail(:to => contact.email, :subject => 'お問い合わせを承りました')
  end
  
  def received_mail(contact)
    @contact = contact
    mail(:to => ENV['SEND_MAIL'], :subject => 'お問い合わせ通知')
  end
  
end
