require 'will_paginate/array'

module Api
  module V1
    class FavoriteController < CommonAPIController
      before_filter :restrict_access

      def index
        @selector = 'favorites.id, 
          favorites.user_id, favorites.data_id,favorites.gubun,
           carsname,
           carsname_lao,
           city,
           address, address_lao,
           cellphone,
           latitude, longitude,
           delyn, detail_lao,
           detail_eng,
           brand, model,
           newold, price,
           price_unit, year,
           odometer, transmission, fueltype,
           drivetype, color,
           bodytype
    	  '
        @models = Car.select(@selector).joins(:favorite)
        if params.has_key?(:user_id)
          @user_id = params[:user_id]
          @models = @models.where("favorites.user_id = #{@user_id}")
        end

        if params.has_key?(:car_ids)
          @car_ids = params[:car_ids]
          @models = @models.where("favorites.data_id in ( #{@car_ids} )")
        else
          @models = paginate @models, per_page:10
        end

        def append_img(model)
          model.image = img_urls(model.data_id)
          if model.image.nil?
            model.image = []
          end
          return model
        end

        @models = @models.map {|model| append_img(model)}
        
        render json: @models
      end

      def destroy
        if params.has_key?(:user_id) and params.has_key?(:car_id)
          @models = Favorite.where("user_id = #{params[:user_id]} and car_id = #{params[:car_id]}")
          @models.delete_all
            render json: {message: 'Resource Deleted'}
        else
          if @model.destroy
            render json: {message: 'Resource Deleted'}
          else
            render json: {message: 'Error occured'}, status:500
          end
        end
      end
      
      private
      def img_urls(carid)
        return Image.select("id, img").where("data_id = :arg", {arg:carid})
      end

      def set_global
        @title = 'Favorite'
        @prefix = 'favorite'
        @Base = Favorite
      end

      def model_params
        params.permit(
          :user_id,
          :data_id,
          :gubun 
        )
      end

      def restrict_access
        apikey = User.find_by_access_token(params[:apikey])
        head :unauthorized unless apikey
      end
    end
  end
end
