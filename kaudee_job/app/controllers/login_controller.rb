require 'digest/md5'
class LoginController < ActionController::Base
  def index
    @user = User.select('id, email, password, sex, tel, usertype, access_token').where(email: params[:email], password: Digest::MD5.hexdigest(params[:password])).take
    if @user
      session[:user] = @user[:email]
      redirect_to root_path
    else
      render json: {message: 'Resource not found'}, status: 404
    end
  end

  def signout
    session[:user] = nil
    redirect_to root_path
  end
end
