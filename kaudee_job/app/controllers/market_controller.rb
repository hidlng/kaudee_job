require 'will_paginate/array'
class MarketController < CommonController
  before_action :restrict_access

  def index
    @models = paginate @Base.select('markets.id, marketname, city, district, keyword, category1, category2, delyn, enable').order("id desc"), per_page: 10
  end

  def new
    @model = @Base.new
  end
  
  def show
    if not @model.present?
      flash[:alert] = @model.errors.values.flatten.join(' ')
      redirect_to :back
    end
    @model.image = img_urls(@model.id)
  end

  def enable
    if params.has_key?(:market_id)
      @market = Market.find_by_id(params[:market_id])
      if @market.present?
        @market.enable = 'yes'
        @market.save
      end
    end
    redirect_to :back
  end

  def disable
    if params.has_key?(:market_id)
      @market = Market.find_by_id(params[:market_id])
      if @market.present?
        @market.enable = nil
        @market.save
      end
    end
    redirect_to :back
  end
  
  private
  def set_global
    @title = 'Market'
    @prefix = 'market'
    @Base = Market
  end
  def img_urls(marketid)
    return Image.select("id, img").where("data_id = :arg and gubun = 1", {arg:marketid})
  end

  def model_params
    params.permit(
      :marketname,
      :marketname_lao,
      :keyword,
      :category1,
      :category2,
      :city,
      :district,
      :address,
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
      :enable
    )
  end
end
