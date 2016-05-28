class MapController < ActionController::Base
  layout "map"
  def list
    @Base = Job
    @fields = 'jobs.*'
    @models = @Base.select(@fields).where(delyn: "no")

    if params.has_key?(:user_id)
      @models = @models.where(user_id: params[:user_id])
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

          if params.has_key?(:category1)
            @category1 = params[:category1]
          end
          if params.has_key?(:category2)
            @category1 = params[:category2]
          end

          @models = @models.where("category1 like :arg or category2 like :category2" , {arg: "%#{@category1}%", category2: "%#{@category2}%"})
        

          if params.has_key?(:jobtitle)
            @jobtitle = params[:jobtitle]
            @models = @models.where("jobtitle like :arg or jobtitle_lao like :arg", {arg: "%#{@jobtitle}%"})
          end
          
           if params.has_key?(:minsalary)
            @minsalary = params[:minsalary]
            @models = @models.where("minsalary like :arg", {arg: "%#{@minsalary}%"})
          end
          
            if params.has_key?(:minsalary_unit)
            @minsalary_unit = params[:minsalary_unit]
            @models = @models.where("minsalary like :arg", {arg: "%#{@minsalary_unit}%"})
          end
          
           if params.has_key?(:salarytype)
            @salarytype = params[:salarytype]
            @models = @models.where("minsalary like :arg", {arg: "%#{@salarytype}%"})
          end
          
           if params.has_key?(:jobtype)
            @jobtype = params[:jobtype]
            @models = @models.where("jobtype like :arg", {arg: "%#{@jobtype}%"})
          end



    @hash = Gmaps4rails.build_markers(@models) do |job, marker|
      marker.lat job.latitude
      marker.lng job.longitude
      marker.picture ({
        "url" => "/mg_house.png",
        "width" => 15,
        "height" => 15 
      })
      marker.infowindow "<a href='kaudee:/api/v1/job/%d'>%s</a>"%[job.id, job.jobtitle]
    end
  end

  def show
    @cars = Job.find(params[:id])
    @hash = Gmaps4rails.build_markers(@jobs) do |job, marker|
      marker.lat job.latitude
      marker.lng job.longitude
      marker.infowindow job.jobtitle
    end
  end

  def new
  end
  def ios
  end

end
