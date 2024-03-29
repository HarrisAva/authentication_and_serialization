class ApplicationController < ActionController::API
    def authenticate_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
            decoded = JWT.decode(header, Rails.application.secrets.secret_key_base).first
            @current_user = User.find(decoded['user_id'])
          rescue JWT::ExpiredSignature
            render json: { error: 'Token has expired' }, status: :unauthorized
          rescue JWT::DecodeError
            render json: { errors: 'Unauthorized' }, status: :unauthorized
          end
    end
end

# last element of the header array is the token.
# the process of decoding the token in a begin rescue block in response to capturing any errors that might occur. If the token has expired, we will return an error message. If the token is invalid, we will return an error message. Otherwise, we will find the user and store it in an instance variable called @current_user.