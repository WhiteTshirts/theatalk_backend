class ApplicationController < ActionController::API
  include JwtAuthenticator
  rescue_from StandardError,:with => :error_500
  def error_500(e)
    render status:500,json:{errors:"例外が発生しました"}
  end
end
