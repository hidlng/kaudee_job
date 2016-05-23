require 'will_paginate/array'
require 'json'

module Api
  module V1
    class CarController < CommonAPIController
      before_filter :restrict_access, except: [:index, :show]

      def index
        @models = @Base.where(delyn: "no")

        if params.has_key?(:user_id)
          @models = @models.where(user_id: params[:user_id])
        end

        if params.has_key?(:odoa) 
          @min = params[:odoa].scan(/\d+/).first
          @models = @models.where("odometer >= ?", @min)
        end
        
        if params.has_key?(:odob)
          @max = params[:odob].scan(/\d+/).first
          @models = @models.where("odometer <= ?", @max)
        end        

        if params.has_key?(:pricea)
          @min = params[:pricea].scan(/\d+/).first
          @models = @models.where("price >= ?", @min)
        end
        
        if params.has_key?(:priceb)
          @max = params[:priceb].scan(/\d+/).first
          @models = @models.where("price <= ?", @max)
        end

        if params.has_key?(:brand)
          @keyword = params[:brand]
          @models = @models.where("brand = :arg", {arg: @keyword})
        end
        
         if params.has_key?(:model)
          @keyword = params[:model]
          @models = @models.where("model = :arg", {arg: @keyword})
        end
        
         if params.has_key?(:newold)
          @keyword = params[:newold]
          @models = @models.where("newold = :arg", {arg: @keyword})
        end

        if params.has_key?(:city)
          @city = params[:city]

          @finded = City.where("cityname like :arg or city_lao like :arg", {arg: "%#{@city}%"})
          @cities ||= []
          @finded.map { |c| @cities << c[:cityname] }
          @finded.map { |c| @cities << c[:city_lao] }
          @str_city = @cities.map { |c| "'#{c}'" } .join(",")
          @info = @str_city

          @models = @models.where("city like :arg or city in (#{@str_city})", {arg: "%#{@city}%"})
        end

        if params.has_key?(:district)
          @district = params[:district]
          @finded = District.where("districtname like :arg or district_lao like :arg", {arg: "%#{@district}%"})
          @dists ||= []
          @finded.map { |d| @dists << d[:districtname] }
          @finded.map { |d| @dists << d[:district_lao] }
          @str_dist = @dists.map { |d| "'#{d}'" } .join(",")
          @info = @str_dist
          @models = @models.where("district like :arg or district in (#{@str_dist})", {arg: "%#{@district}%"})
        end

        if params.has_key?(:bounds)
          @bounds = JSON(params[:bounds])
          @models = @models.where("latitude >= :swlat and latitude <= :nelat and longitude >= :swlng and longitude <= :nelng", 
              {
                swlat: @bounds[0],
                nelat: @bounds[2],
                swlng: @bounds[1],
                nelng: @bounds[3]
              })
        end


        @models = paginate @models.order("id desc"), per_page: 10
  
        @models = @models.map {|model| append_img(model)}
        render json: @models
      end

      def show
        @fields = 'cars.*'
        @model = @Base.select(@fields).find(params[:id])
        @model = append_img(@model)
        render json: @model
      end

      def create
        @model = @Base.new(model_params)
        if @model.present?
          if session[:user]
            @model.user_id = session[:user].id
          end
          if @model.save
            render json: @model
          else
            render json: {message: 'Car Insert Error'}, status: 500
          end
        else
          render json: {message: 'Wrong Parameter'}, status: 500
        end
      end

      def update
        if @model.update(model_params)
          if not params.has_key?(:save)
            img_delete(@model.id)
          end
          render json: @model
        else
          render json: {message: 'Error occured'}, status:500
        end
      end

      def destroy
        if @model.destroy
          img_delete(@model.id)
          render json: {message: 'Resource Deleted'}
        else
          render json: {message: 'Error occured'}, status:500
        end
      end

      private
      def img_urls(carid)
        return Image.select("id, img").where("data_id = :arg and gubun = 3", {arg:carid})
      end
      def img_delete(carid)
        Image.where("data_id = :arg and gubun = 3", {arg:carid}).destroy_all
      end

      def set_global
        @title = 'Car'
        @prefix = 'Car'
        @Base = Car 
      end

      def model_params
        params.permit(
         :carsname,
         :carsname_lao,
         :city,
         :distinct,
         :user_id,
        
         :address,
         :address_lao,
         :cellphone,
        
         :latitude,
         :longitude,
         :delyn,
         :detail_lao,
         :detail_eng,
  
         :brand,
         :model,
         :newold,
         :price,
         :price_unit,
         :year,
         :odometer,
         :transmission,
         :fueltype,
         :drivetype,
         :color,
         :bodytype,

        )
      end

      def append_img(model)
        model.image = img_urls(model.id)
        if model.image.nil?
          model.image = []
        end
        return model
      end

      def restrict_access
        apikey = User.find_by_access_token(params[:apikey])
        head :unauthorized unless apikey
      end
    end
  end
end
