require 'will_paginate/array'
class JobController < CommonController
  
  private
  def set_global
    @title = 'Job'
    @prefix = 'job'
    @Base = Job 
  end
end
