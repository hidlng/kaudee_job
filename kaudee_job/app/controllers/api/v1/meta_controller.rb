module Api
  module V1
    class MetaController < ApplicationController
      def index
        @ret = {
          'category'=>Category.select("id, categoryname, categorylao").all,
          'brand'=>Carbrand.select("id, brandname").all,
          'carmodel'=>Carmodel.select("id, brand_id, modelname").all,
          'city'=>City.select("id, cityname, city_lao").all,
          'district'=>District.select("id, districtname, district_lao, city_id").all
        }
        render json: @ret
      end
    end
  end
end

