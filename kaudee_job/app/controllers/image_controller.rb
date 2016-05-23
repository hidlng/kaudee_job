class ImageController < CommonController
  
  def new
  end

  def show
  end

  private
  def set_global
    @title = 'Image'
    @prefix = 'image'
    @Base = Image
  end

  def model_params
    params.permit(
      :data_id,
      :img,
      :gubun
    )
  end
end
