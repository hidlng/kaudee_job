require 'will_paginate/array'

class UserController < CommonController
  before_action :restrict_access

  def index
    @selector = "id, email, password, sex, tel, birthdate, access_token, empno, recomno"
    @models = paginate @Base.select(@selector).order("id desc").all, per_page:10
  end

  def admin
    @selector = "id, email, password, sex, tel, birthdate, access_token, empno, recomno"
    @models = paginate @Base.select(@selector).order("id desc").where("empno <> ''"), per_page:10
  end
    

  def show
    if not @model.present?
        flash[:alert] = @model.errors.values.flatten.join(' ')
        redirect_to :back
    end
  end

  def geno
    if params.has_key?(:uid)
      @user = User.find(params[:uid])
      if @user.empno == nil
        @randno = rand(10000..99999)
        while User.exists?(:empno => @randno)
          @randno = rand(10000..99999)
        end
        @user.empno = @randno 
        @user.save
      end
      redirect_to :back
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
      :sex, 
      :tel, 
      :birthdate,
      :empno,
      :recomno
    )
  end
end
