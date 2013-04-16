class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
    @category = @product.category
  end

  def yandex
    render :text => YandexMarketApi.generate_yml
  end
end
