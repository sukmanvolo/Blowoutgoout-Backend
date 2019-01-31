module Api
  module V1
    class ServicesController < ApplicationController
      before_action :set_service, only: [:show, :update, :destroy]

      # GET /services
      def index
        @services = service.all
        json_response(@services)
      end

      # POST /services
      def create
        @service = service.create!(service_params)
        json_response(@service, :created)
      end

      # GET /services/:id
      def show
        json_response(@service)
      end

      # PUT /services/:id
      def update
        @service.update(service_params)
        head :no_content
      end

      # DELETE /services/:id
      def destroy
        @service.destroy
        head :no_content
      end

      private

      def service_params
        # whitelist params
        params.permit(:name, :service_type)
      end

      def set_service
        @service = service.find(params[:id])
      end
    end  
  end  
end
