class ReservationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @aeroplane = Aeroplane.find(params[:aeroplane_id])
    @reservations = @aeroplane.reservations.where(user_id: current_user.id).all
    render json: @reservations
  end
  def show
    @aeroplane = Aeroplane.find(params[:aeroplane_id])
    @reservation = @aeroplane.reservations.find(params[:id])
    render json: @reservation, include: [:user], status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Reservation not found' }, status: :not_found
  end
  
