module JwtAuthenticator
  require "jwt"
  extend ActiveSupport::Concern

  module ClassMethods
    def jwt_authenticate(**options)
      class_eval do
        prepend_before_action :jwt_authenticate, options
      end
    end
  end

  SECRET_KEY = Rails.application.secrets.secret_key_base

  def jwt_authenticate
    if request.headers['Authorization'].blank?
      render status: 401, json: {error: '認証情報不足'}
      return
    end

    encoded_token = request.headers['Authorization'].split('Bearer ').last
    payload = decode(encoded_token)

    @current_user = User.find_by(id: payload["user_id"])
    if @current_user.nil?
      return
    end
    @current_user
  end

  def encode(user_id)
    expire_in = 1.week.from_now.to_i
    preload = { user_id: user_id, exp: expire_in }
    JWT.encode(preload, SECRET_KEY, 'HS256')
  end

  def decode(encoded_token)
    begin
      decoded_jwt = JWT.decode(encoded_token, SECRET_KEY, true, algorithm: 'HS256')
      decoded_jwt.first
    rescue => e
      render status: 401, json: {error: '期限切れ'}
      return { "user_id": -1 }
    end
  end
end