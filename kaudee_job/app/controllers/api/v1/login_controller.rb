module Api
  module V1
    class LoginController < ApplicationController
      def index
        @user = User.select('id, email, password, name, sex, tel, birthdate, usertype, access_token').where(email: params[:email], password: params[:password]).take
        if @user
          session[:user] = @user
          render json: @user
        else
          render json: {message: 'Resource not found'}, status: 404
        end
      end
    end
  end
end
