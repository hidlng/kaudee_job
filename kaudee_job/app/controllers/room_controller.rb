require 'will_paginate/array'
class RoomController < CommonController
	
  private
  def set_global
    @title = 'Room'
    @prefix = 'room'
    @Base = Room 
  end
end
