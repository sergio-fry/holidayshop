class ApplicationController < ActionController::Base
  before_filter :check_www, :check_heroku_app if Rails.env.production?

  protect_from_forgery

  private

  def check_heroku_app
    redirect_to request.protocol + "www.prazdnik-magazin.ru" + request.path if request.host.match(/heroku/)
  end

  def check_www
    redirect_to request.protocol + "www." + request.host_with_port + request.path if !/^www/.match(request.host)
  end
end
