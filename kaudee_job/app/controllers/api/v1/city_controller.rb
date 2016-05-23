module Api
  module V1
    class CityController < CommonAPIController

      private
      def set_global
        @title = 'City'
        @prefix = 'city'
        @Base = City
      end

      def model_params
        params.permit(
          :cityname,
          :city_lao
        )
      end

    end
  end
end
