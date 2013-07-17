class StaticController < ApplicationController
  def show
    @page = Page.find_by_permalink(params[:permalink])
    render(:text => "Not found", :status => 404) if @page.blank?
  end
end
