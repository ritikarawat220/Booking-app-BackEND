class ReservationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @aeroplane = Aeroplane.find(params[:aeroplane_id])
    @reservations = @aeroplane.reservations.where(user_id: current_user.id).all
    render json: @reservations, each_serializer: ReservationSerializer
  end

  def show
    @aeroplane = Aeroplane.find(params[:aeroplane_id])
    @reservation = @aeroplane.reservations.find(params[:id])
    render json: @reservation, serializer: ReservationSerializer
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Reservation not found' }, status: :not_found
  end

  def new
    @aeroplane = current_user.aeroplanes.find_by(params[:id])
    @reservation = @aeroplane.reservations.new
  end

  def create
    @aeroplane = Aeroplane.find(params[:aeroplane_id])
    @reservation = current_user.reservations.build(reservation_params.merge(aeroplane: @aeroplane))
    if @reservation.save
      render json: @reservation, status: :created
    else
      render json: { errors: @reservation.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @aeroplane = Aeroplane.find(params[:aeroplane_id])
    @reservation = @aeroplane.reservations.find(params[:id])
    if @reservation.destroy
      render json: { message: 'Reservation deleted successfullu' }, status: :ok
    else
      render json: { error: @reservation.errors }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Reservation not found' }, status: :not_found
  end

  private

  def reservation_params
    params.required(:reservation).permit(:reservation_date, :returning_date, :city)
  end
end