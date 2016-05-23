class PasswordResetsController < ActionController::Base
  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    if user
      render json: {:email=>params[:email], :message=>"success"}
    else
      render json: {:message=>"not found"}
    end
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif params.has_key? (:user) and params[:user][:password] == params[:user][:password_confirmation]
      @user.update(:password=>Digest::MD5.hexdigest(params[:user][:password]))
      #redirect_to root_url, :notice => "Password has been reset!"
      render json: {:message=>"Password has been reset!", :user=>@user[:email]}
    else
      render :edit
    end
  end
end
