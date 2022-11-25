class BookingsController < ApplicationController
  def index
    @user = current_user
    # @theorist = Theorist.find(params[:theorist_id])
    @bookings = Booking.all
  end

  def show
    @theorist = Theorist.find(params[:theorist_id])
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
    @theorist = Theorist.find(params[:theorist_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.theorist = Theorist.find(params[:theorist_id])
    if @booking.save
      redirect_to bookings_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to theorist_bookings_path, status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
