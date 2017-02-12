class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
  end

  def show
    @reservation = Reservation.new
  end

  def new
    @reservation = Reservation.new
  end

  def create
    reservation = Reservation.new(reservation_params)
    reservation.user = User.find(session[:user_id])

    if reservation.save
      redirect_to user_path(reservation.user)
    else
      redirect_to restaurant_path(params[:reservation][:restaurant_id])
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    @user = User.find_by(id: @reservation.user_id)

    if @reservation.update_attributes(reservation_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to restaurants_url
  end

  private
  def reservation_params
   params.require(:reservation).permit(:party_size, :date, :restaurant_id, :user_id, :res_time)
  end

end
