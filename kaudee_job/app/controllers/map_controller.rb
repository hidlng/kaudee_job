class MapController < ActionController::Base
  layout "map"
  def list
    @Base = Car
    @fields = 'cars.*'
    @models = @Base.select(@fields).where(delyn: "no")

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

    if params.has_key?(:lat)
      @lat = params[:lat]
      if @lat.to_s.strip.length == 0
        @models = @modes.where("latitude + 0.1 >= :wlat and latitude - 0.1 <= elat", {wlat: @lat, elat: @lat})
      end
    end
    if params.has_key?(:lng)
      @lng = params[:lng]
      if @lng.to_s.strip.length == 0
        @models = @modes.where("longitude + 0.1 >= :nlng and longitude - 0.1 <= slng", {nlng: @lng, slng: @lng})
      end
    end

    @hash = Gmaps4rails.build_markers(@models) do |car, marker|
      marker.lat car.latitude
      marker.lng car.longitude
      marker.picture ({
        "url" => "/mg_house.png",
        "width" => 15,
        "height" => 15 
      })
      marker.infowindow "<a href='kaudee:/api/v1/car/%d'>%s</a>"%[car.id, car.model]
    end
  end

  def show
    @cars = Car.find(params[:id])
    @hash = Gmaps4rails.build_markers(@cars) do |car, marker|
      marker.lat car.latitude
      marker.lng car.longitude
      marker.infowindow car.carname
    end
  end

  def new
  end
  def ios
  end

end
