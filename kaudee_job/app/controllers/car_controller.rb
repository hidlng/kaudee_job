require 'will_paginate/array'
class CarController < CommonController
  
  private
  def set_global
    @title = 'Car'
    @prefix = 'car'
    @Base = Car 
  end
end
