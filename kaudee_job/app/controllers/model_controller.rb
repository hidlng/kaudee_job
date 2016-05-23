class ModelController < CommonController
  private
  def set_global
    @title = 'Carmodel'
    @prefix = 'model'
    @Base = Carmodel
  end

  def model_params
    params.permit(
      :modelname,
      :brand_id 
    )
  end
end
