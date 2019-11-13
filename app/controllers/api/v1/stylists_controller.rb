module Api::V1
  class StylistsController < BaseController
    before_action :set_stylist, only: [:show, :update, :destroy,
                                       :gallery_images, :remove_gallery_image]

    # GET /stylists
    def index
      @stylists = Stylist.all
      authorize @stylists
      json_response(@stylists)
    end

    # POST /stylists only for admin
    def create
      @stylist = Stylist.new(stylist_params)
      authorize @stylist
      @stylist.save!
      json_response(@stylist, :created)
    end

    # GET /stylists/:id
    def show
      render json: @stylist, serializer: ShowStylistSerializer, status: status
      # json_response(@stylist)
    end

    # PUT /stylists/:id
    def update
      authorize @stylist
      stylist_data = stylist_params
      user_data = stylist_data.delete :user_attributes
      @stylist.user.update(user_data) if user_data
      if @stylist.update(stylist_data)
        json_response(@stylist, :accepted)
      else
        json_response(@stylist.errors.messages, :unprocessable_entity)
      end
      head :no_content
    end

    # DELETE /stylists/:id
    def destroy
      authorize @stylist
      @stylist.destroy
      head :no_content
    end

    # GET /stylists/nearest_stylists
    def nearest_stylists
      @stylists = Stylist.nearest_stylists(params[:lat], params[:long])
      json_response(@stylists)
    end

    def available_stylists
      stylists = Stylist.nearest_stylists(params[:lat], params[:long])

      stylist_schedules = StylistSchedule
                                          .joins(:schedule)
                                          .where(schedules: { date: params[:date] })
                                          .where(stylist_schedules: {
                                                   stylist_id: stylists
                                                  }
                                                 )

      stylist_schedules = stylist_schedules.where(start_time: params[:start_time]) if params[:start_time]

      # filter by service_ids array
      stylist_schedules = stylist_schedules.reject { |sc| (sc.schedule.service_ids & service_ids).empty? } if service_ids

      # get stylist ids
      stylist_ids = []
      stylist_schedules.each do |sc|
        stylist_ids << sc.stylist_id
      end

      @stylists = stylists.where(id: stylist_ids.uniq)
      @stylists = @stylists.update(tmp_client_id: current_user.client.id)
      json_response(@stylists)
    end

    def gallery_images
        # authorize @stylist
      if @stylist.update(gallery_images_params)
        render json: @stylist, serializer: GalleryImagesStylistSerializer, status: status
      else
        json_response(@stylist.errors.messages, :unprocessable_entity)
      end
    end

    def remove_gallery_image
      @stylist.gallery_images.where(id: params[:image_id]).purge
      head :no_content
    end

    private

    def stylist_params
      params.require(:stylists).permit(:years_of_experience, :license_agreement,
                                       :has_smartphone, :has_transportation,
                                       :portfolio_link, :is_eligible_to_work_in_us,
                                       :previous_contractor_date, :has_conviction,
                                       :agrees_to_unemployment_understanding,
                                       :agrees_to_taxation_understanding,
                                       :status, :description, :welcome_kit,
                                       :lat, :long, :user_id, :radius, :image,
                                       user_attributes: [
                                        :first_name, :last_name, :phone,
                                        :email, :password, :gcm_id,
                                        :device_type, :device_id]
                                       )
    end

    def gallery_images_params
      params.require(:stylists).permit(gallery_images: [])
    end

    def set_stylist
      @stylist = Stylist.find(params[:id])
    end

    def service_ids
      return params[:service_ids] unless params[:service_ids].is_a? String
      JSON.parse(params[:service_ids])
    end
  end
end
