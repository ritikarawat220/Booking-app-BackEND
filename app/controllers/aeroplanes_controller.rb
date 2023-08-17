class AeroplanesController < ApplicationController
  before_action :authenticate_user!

  def index
    @aeroplanes = Aeroplane.all
    render json: @aeroplanes
  end

  def show
    @aeroplane = Aeroplane.find(params[:id])
    render json: @aeroplane
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'The chosen aeroplane id does not exist' }, status: :not_found
  end

  def new
    @aeroplane = Aeroplane.new
    @aeroplane
  end

  def create
    @aeroplane = current_user.aeroplanes.build(aeroplane_params)

    if @aeroplane.save
      render json: @aeroplane, status: :created
    else
      render json: @aeroplane.errors.full_message.to_sentence, status: :unprocessable_entry
    end
  end

  def destroy
    @aeroplane = Aeroplane.find_by(id: params[:id]) # Use find_by instead of find

    if @aeroplane
      if @aeroplane.destroy
        render json: { message: 'Aeroplane successfully deleted' }
      else
        render json: { message: 'Wrong entry check and try again' }, status: :unprocessable_entity
      end
    else
      render json: { message: 'Aeroplane not found' }, status: :not_found
    end
  end

  def aeroplane_params
    params.require(:aeroplane).permit(:name, :model, :description, :price, :booking_price, :image)
  end
end
