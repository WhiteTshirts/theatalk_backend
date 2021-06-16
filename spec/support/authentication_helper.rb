module AuthenticationHelper
    def sign_in(user)
        post "/api/v1/login",params:{user:{name:user.name,password:user.password}},
        as: :json
        json = JSON.parse(response.body)
        @token = json["token"]
        @headers = {'Authorization' => "Bearer #{@token}"}
    end
end