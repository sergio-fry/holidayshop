class StaticController < ApplicationController
  def show
    @page = Page.find_by_permalink(params[:permalink])
  end

  def about
  end

  def delivery
  end
end
