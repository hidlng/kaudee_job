class BrandController < CommonController
  private
  def set_global
    @title = 'Carbrand'
    @prefix = 'brand'
    @Base = Carbrand
  end

  def model_params
    params.permit(
      :brandname,
      :brand_option
    )
  end
end
