class ApplicationController < ActionController::API
  include JwtAuthenticator
  rescue_from StandardError,:with => :error_500
  rescue_from ActiveRecord::RecordNotFound,with: :error_404
  def error_500(message="Server Error")
    render status:500,json:{errors:message}
  end
  def error_404(message="not found")
    render status:404,json:{errors:message}
  end
  def error_422(message="Unprocessable Entity")
    render staus:422,json:{errors:message}
  end
  def error_409(message="Conflict")
    render status:409,json:{errors:message}
  end
end
