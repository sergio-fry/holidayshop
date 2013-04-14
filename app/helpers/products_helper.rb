# encoding: utf-8
module ProductsHelper
  def product_price(product)
    number_to_currency(product.price2 || product.price, :unit => "руб.")
  end
end
