class OrdersController < ApplicationController
  layout 'order'

  def create
    @order = Order.new(params[:order])

    if @order.save
      redirect_to order_path(@order.uuid)
    else
      render :action => :new
    end
  end

  def new
    @order = Order.new(params[:order])
  end

  def show
    @order = Order.find_by_uuid!(params[:id])
  end
end
