class DistrictController < CommonController
  private
  def set_global
    @title = 'District'
    @prefix = 'district'
    @Base = District 
  end

  def model_params
    params.permit(
      :districtname,
      :district_lao, 
      :city_id
    )
  end
end
