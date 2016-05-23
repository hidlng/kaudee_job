module Api
  module V1
    class CommonAPIController < ApplicationController
      before_action :set_global
      before_action :set_model, only: [:show, :edit, :update, :destroy]

      def index
        @models = @Base.all
        render json: @models
      end

      def show
        if @model.present?
          render json: @model
        else
          render json: {message: 'Error occured'}, status:500
        end
      end

      def create
        @model = @Base.new(model_params)
        if @model.present?
          if @model.save
            render json: @model
          else
            render json: {message: 'Error occured'}, status:500
          end
        end
      end

      def update
        if @model.update(model_params)
          render json: @model
        else
          render json: {message: 'Error occured'}, status:500
        end
      end

      def destroy
        if @model.destroy
          render json: {message: 'Resource Deleted'}
        else
          render json: {message: 'Error occured'}, status:500
        end
      end

      private
      def set_global
        @title = 'Base'
        @prefix = 'base'  
        @Base = Base
      end

      def set_model
        @model = @Base.find(params[:id])
      end

      def model_params
        params.permit(:id)
      end
    end
  end
end

