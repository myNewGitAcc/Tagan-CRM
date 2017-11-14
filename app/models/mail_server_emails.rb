class MailServerEmails < ActiveRecord::Base
  belongs_to :user

  after_create  :cut_mail

  private

  def cut_mail

    address_from = self.body.scan(/Return-Path: <(.*)>/)[0][0]
    address_to = self.body.scan(/Delivered-To: <(.*)>/)[0][0]
    #self.update_attributes(user_id: User.find_by_email(address_to).id)
    self.update_attributes(address_from: address_from, address_to: address_to)

    if self.body.match(/Content-Transfer-Encoding: base64/)
      self.update_attributes(body: Base64.decode64(self.body.scan(/Content-Transfer-Encoding: base64(.*)/m)[0][0]))
    elsif self.body.match(/Content-Type: text\/html./)
      self.update_attributes(body: self.body.scan(/Content-Type: text\/html.(.*)/m)[0][0])
    elsif self.body.match(/Content-Type: text\/plain./)
      self.update_attributes(body: self.body.scan(/Content-Type: text\/plain.(.*)/m)[0][0])
    else
      self.update_attributes(body: "Sorry, this message have unknown Content-Type. Please, check you email manually")
    end

  end

end