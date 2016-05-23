module Api
  module V1
    class CategoryController < CommonAPIController

      private
      def set_global
        @title = 'Category'
        @prefix = 'category'
        @Base = Category
      end

      def model_params
        params.permit(
          :categoryeng,
          :categoryname 
        )
      end

    end
  end
end
