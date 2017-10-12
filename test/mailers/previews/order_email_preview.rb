class OrderMailerPreview < ActionMailer::Preview
  def order_email
    OrderMailer.order_email(Order.last)
  end
end