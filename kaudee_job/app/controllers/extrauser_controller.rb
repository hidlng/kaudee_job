class ExtrauserController < CommonController
  private
  def set_global
    @title = 'Extrauser'
    @prefix = 'extrauser'
    @Base = Extrauser
  end

  def model_params
    params.permit(
       :postedDate,
       :category1,
       :category2,
       :skills,
       :skills_lao,
       :jobType,
       :minSalary,
       :minSalary_unit,
       :salaryType,
      
       :resume,
       :resume_lao,
       :coverLetter,
       :coverLetter_lao,
      
       :city,
       :district
    )
  end
end
