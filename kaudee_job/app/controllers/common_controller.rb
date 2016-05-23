class CommonController < ActionController::Base
  before_action :set_global
  before_action :set_model, only: [:show, :edit, :update, :destroy]
  layout "application"

  def index
    @models = paginate @Base.order("id desc").all, per_page: 10
    render :template => 'shared/index'
  end

  def show
    if not @model.present?
        flash[:alert] = @model.errors.values.flatten.join(' ')
        redirect_to :back
    end
    render :template => 'shared/show'
  end

  def new
    @model = @Base.new
    render :template => 'shared/new'
  end

  def edit
    if not @model.present?
        flash[:alert] = @model.errors.values.flatten.join(' ')
        redirect_to :back
    end
    render :template => 'shared/edit'
  end

  def create
    @model = @Base.new(model_params)
    if @model.present?
      if @model.save
        redirect_to "/#{@prefix}/#{@model.id}"
      else
        flash[:alert] = @model.errors.values.flatten.join(' ')
        redirect_to :back
      end
    end
  end

  def update
    if @model.update(model_params)
      redirect_to "/#{@prefix}/#{@model.id}"
    else
      flash[:alert] = @model.errors.values.flatten.join(' ')
      redirect_to :back
    end
  end

  def destroy
    if @model.destroy
      redirect_to "/#{@prefix}"
    else
      flash[:alert] = @model.errors.values.flatten.join(' ')
      redirect_to :back
    end
  end


  private
  def set_global
    @title = 'Base'
    @prefix = 'base'  
    @Base = Base
  end

  def set_model
    @model = @Base.find(params[:id])
  end

  def model_params
    params.permit(:id)
  end

  def restrict_access
    if session[:user].nil?
      flash[:notice] = "Please Login"
      redirect_to "/"
      return false
    else
      return true
    end

  end
end
