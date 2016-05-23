class CategoryController < CommonController
  private
  def set_global
    @title = 'Category'
    @prefix = 'category'
    @Base = Category
  end

  def model_params
    params.permit(
      :categoryeng,
      :categoryname, 
      :language,
      :useyn
    )
  end
end
