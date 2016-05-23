require 'will_paginate/array'
require 'json'

module Api
  module V1
    class MarketController < CommonAPIController
      before_filter :restrict_access, except: [:index, :show]

      def index
        @fields = 'markets.*'
        @models = @Base.select(@fields).where(delyn: "no")
        
        @info = []
        if params.has_key?(:user_id)
          @models = @models.where(user_id: params[:user_id])
        end

        if params.has_key?(:category1) and params.has_key?(:category2)
          @cate1 = params[:category1]
          @cate2 = params[:category2]

          @finded = Category.where("categoryname like :arg1 or categorylao like :arg1 or categoryname like :arg2 or categorylao like :arg2", {arg1: "%#{@cate1}%", arg2: "%#{@cate2}%"})
          @cates ||= []
          @finded.map { |c| @cates << c[:categoryname] }
          @finded.map { |c| @cates << c[:categorylao] }
          @str_cate = @cates.map { |c| "'#{c}'" } .join(",")
          @info = @str_cate

          @models = @models.where("category1 like '%#{@cate1}%' or category2 like '%#{@cate1}%' or category1 like '%#{@cate2}%' or category2 like '%#{@cate2}%' or category1 in (#{@str_cate}) or category2 in (#{@str_cate})")
        else
          if params.has_key?(:category1)
            @cate = params[:category1]
          end
          if params.has_key?(:category2)
            @cate = params[:category2]
          end
          @finded = Category.where("categoryname like :arg or categorylao like :arg", {arg: "%#{@cate}%"})
          @cates ||= []
          @finded.map { |c| @cates << c[:categoryname] }
          @finded.map { |c| @cates << c[:categorylao] }
          @str_cate = @cates.map { |c| "'#{c}'" } .join(",")
          @info = @str_cate

          @models = @models.where("category1 like :arg or category2 like :arg or category1 in (#{@str_cate}) or category2 in (#{@str_cate})", {arg: "%#{@cate}%"})
        end

        if params.has_key?(:name)
          @name = params[:name]
          @models = @models.where("keyword like '%#{@name}%' or keyword_lao like '%#{@name}%' or marketname like '%#{@name}%' or marketname_lao like '%#{@name}%'")
        elsif params.has_key?(:keyword) and params.has_key?(:marketname)
          @keyword = params[:keyword]
          @marketname = params[:marketname]
          @models = @models.where("keyword like '%#{@keyword}%' or keyword_lao like '%#{@keyword}%' or marketname like '%#{@marketname}%' or marketname_lao like '%#{@marketname}%'")
        else
          if params.has_key?(:keyword)
            @keyword = params[:keyword]
            @models = @models.where("keyword like :arg or keyword_lao like :arg", {arg: "%#{@keyword}%"})
          end

          if params.has_key?(:marketname)
            @marketname = params[:marketname]
            @models = @models.where("marketname like :arg or marketname_lao like :arg", {arg: "%#{@marketname}%"})
          end
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
        #render json: {:models=>@models, :info=>@info}
      end

      def show
        @fields = 'markets.*'
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
            render json: {message: 'Market Insert Error'}, status: 500
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
      def img_urls(marketid)
        return Image.select("id, img").where("data_id = :arg and gubun = 1", {arg:marketid})
      end
      def img_delete(marketid)
        Image.where("data_id = :arg and gubun = 1", {arg:marketid}).destroy_all
      end

      def set_global
        @title = 'Market'
        @prefix = 'market'
        @Base = Market
      end

      def model_params
        params.permit(
          :marketname,
          :marketname_lao,
          :category1,
          :category2,
          :keyword,
          :keyword_lao,
          :city,
          :district,
          :address,
          :address_lao,
          :open1,
          :close1,
          :desc1,
          :open2,
          :close2,
          :desc2,
          :open3,
          :close3,
          :desc3,
          :fax,
          :cellphone,
          :tel,
          :tel2,
          :email,
          :homepage,
          :latitude,
          :longitude,
          :delyn,
          :detail_lao,
          :detail_eng,
          :user_id,
          :keyword,
          :keyword_lao
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
