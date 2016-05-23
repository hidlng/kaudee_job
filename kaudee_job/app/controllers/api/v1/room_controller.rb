require 'will_paginate/array'
require 'json'

module Api
  module V1
    class RoomController < CommonAPIController
      before_filter :restrict_access, except: [:index, :show]

      def index
        @models = @Base.where(delyn: "no")

        if params.has_key?(:user_id)
          @models = @models.where(user_id: params[:user_id])
        end

	if params.has_key?(:deposita) and params.has_key?(:depositb)
		@min = params[:deposita].scan(/\d+/).first || 0
		@max = params[:depositb].scan(/\d+/).first || 0
		@models = @models.where("deposit >= ? and deposit <= ?", @min, @max)
	end

	if params.has_key?(:renta) and params.has_key?(:rentb)
		@min = params[:renta].scan(/\d+/).first
		@max = params[:rentb].scan(/\d+/).first
		@models = @models.where("rent >= ? and rent <= ?", @min, @max)
	end


	if params.has_key?(:deposit_base) and params.has_key?(:deposit_range)
	  @min = params[:deposit_base].to_i - params[:deposit_range].to_i
	  @max = params[:deposit_base].to_i + params[:deposit_range].to_i
	  @models = @models.where("deposit >= ? and deposit <= ?", @min, @max)
	end

	if params.has_key?(:rent_base) and params.has_key?(:rent_range)
	  @min = params[:rent_base].to_i - params[:rent_range].to_i
	  @max = params[:rent_base].to_i + params[:rent_range].to_i
	  @models = @models.where("rent >= ? and rent <= ?", @min, @max)
	end

	if params.has_key?(:rstruct)
	  @models.where(rsturct: params[:rstruct])
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
        @fields = 'rooms.*'
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
            render json: {message: 'Room Insert Error'}, status: 500
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
      def img_urls(roomid)
        return Image.select("id, img").where("data_id = :arg and gubun = 2", {arg:roomid})
      end
      def img_delete(roomid)
        Image.where("data_id = :arg and gubun = 2", {arg:roomid}).destroy_all
      end

      def set_global
        @title = 'Room'
        @prefix = 'Room'
        @Base = Room 
      end

      def model_params
        params.permit(
          :address,
          :address_lao,
          :cellphone,
          :tel,
          :email,
          :latitude,
          :longitude,
          :delyn,
          :detail_lao,
          :detail_eng,
          :user_id,
          :status,
          :product,
          :price,
          :price_unit,
          :land_size,
          :rooms,
          :toilets,
          :built_year,
          :amenities,
          :parking,
          :rent_option,
          :city,
          :district
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
