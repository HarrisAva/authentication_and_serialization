class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      token = jwt_encode(user_id: user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
  # token - encoding the payload and storing it 'token'. We are passing in the user's id as the payload.

  private
  def jwt_encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i 
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end
end

# The payload represents the data that we want to include in our token. This is typically used for storing the user's id.
# The default expiration time to 24 hours from now
# The secret key base is unique to your application which is used for security purposes. It is used also to encrypt sensitive data such as the Rails credentials feature which is used to hold sensitive information such as API keys, passwords

# The & is called the safe navigation operator. It's a Ruby operator that allows you to call a method on an object without worrying if it is nil. If the object is nil, the method will return nil instead of raising an exception.
# if the user is found and the password is correct, we will return a token. Otherwise, we will return an error message
