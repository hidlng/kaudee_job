require 'will_paginate/array'
require 'json'

module Api
  module V1
    class ModelController < CommonAPIController

      def create
        @model = @Base.new(model_params)
        if @model.present?
          if @model.save
            render json: @model
          else
            render json: {message: 'Model Insert Error'}, status: 500
          end
        else
          render json: {message: 'Wrong Parameter'}, status: 500
        end
      end

      def set_global
        @title = 'Carmodel'
        @prefix = 'model'
        @Base = Carmodel
      end

      def model_params
        params.permit(
          :modelname,
          :brand_id 
        )
      end


    end
  end
end
