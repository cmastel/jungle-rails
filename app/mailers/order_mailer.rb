class OrderMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def receipt_email(param)
    @order = param
    mail(to: 'chris.mastel@gmail.com', subject: "Your order was successfully processed")
  end
end


