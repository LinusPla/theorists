class TheoristsController < ApplicationController
  def index
    if params[:query].present?
      # sql_query = "stage_name ILIKE :query OR main_theory ILIKE :query"
      # @theorists = Theorist.where(sql_query, query: "%#{params[:query]}%")
      @theorists = Theorist.search_by_stage_name_and_main_theory(params[:query])
    else
      @theorists = Theorist.all
    end
  end

  def new
    @theorist = Theorist.new
  end

  def create
    @theorist = Theorist.new(theorist_params)
    @theorist.user = current_user
    if @theorist.save!
      redirect_to theorists_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @theorist = Theorist.find(params[:id])
  end

  def update
    @theorist = Theorist.find(params[:id])
    @theorist.update(theorist_params)
    @redirect_to_theorists
  end

  def show
    @theorist = Theorist.find(params[:id])
    @booking = Booking.new
    @bookings = Booking.where(theorist: @theorist)
    @review = Review.new
  end

private

  def theorist_params
    params.require(:theorist).permit(:stage_name, :main_theory, :sources, :price, :location, :photo)
  end

end
