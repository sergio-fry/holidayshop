class OrdersNotifier < ActionMailer::Base
  default from: "ipbaranova@gmail.com"

  def new_order(order)
    @order = order
    mail(:to => order.email,
         :bcc => ["ipbaranova@gmail.com", "upostale@gmail.com"])
  end
end
