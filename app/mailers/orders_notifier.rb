class OrdersNotifier < ActionMailer::Base
  default from: "upostale@gmail.com"

  def new_order(order)
    @order = order
    mail(:to => order.email,
         :bcc => ["upostale@gmail.com"])
  end
end
