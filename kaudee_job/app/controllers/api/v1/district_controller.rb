module Api
  module V1
    class DistrictController < CommonAPIController

      private
      def set_global
        @title = 'District'
        @prefix = 'district'
        @Base = District
      end

      def model_params
        params.permit(
          :districtname,
          :district_lao
        )
      end

    end
  end
end
