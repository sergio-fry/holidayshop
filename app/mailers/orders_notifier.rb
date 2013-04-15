class OrdersNotifier < ActionMailer::Base
  default from: "from@example.com"

  def new_order(order)
    @order = order
    mail(:to => order.email,
         :bcc => ["upostale@gmail.com"])
  end
end
