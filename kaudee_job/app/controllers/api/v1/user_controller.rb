module Api
  module V1
    class UserController < CommonAPIController
      before_filter :restrict_access, except: [:create]

      def index
        @selector = "id, email, name, sex, tel, birthdate, usertype, empno, recomno"
        @users = @Base.all
        if params.has_key?(:email)
          @email = params[:email]
          @users.select(@selector).where("email = :arg", {arg: "%#{@email}%"})
        end
        render json: @users
      end

      def show
        @selector = "id, email, name, sex, tel, birthdate, usertype, empno, recomno"
        if params.has_key?(:usertype)
          @usertype = params[:usertype]
          if @usertype == "company"
            @selector = "id, email, name, sex, tel, birthdate, usertype, marketname, marketphone, marketemail, address, cellphone, empno, recomno"
          end
        end
        @user = @Base.select(@selector).find(params[:id])

        render json: @user
      end

      def create
        @model = @Base.new(model_params)
        if @model.present?
          if @model.save
            render json: @model
          else
            render json: {message: 'Already Signed Email'}, status:500
          end
        end
      end

      private
      def set_global
        @title = 'User'
        @prefix = 'user'
        @Base = User
      end

      def model_params
        params.permit(
          :email, 
          :password, 
          :name, 
          :tel, 
          :sex, 
          :birthdate, 
          :usertype,
          :marketname,
          :cellphone,
          :marketphone,
          :marketemail,
          :address,
          :empno,
          :recomno
          )
      end

      def restrict_access
        apikey = User.find_by_access_token(params[:apikey])
        head :unauthorized unless apikey
      end
    end
  end
end
