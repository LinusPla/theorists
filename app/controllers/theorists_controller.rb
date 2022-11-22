class TheoristsController < ApplicationController
  def index
    @theorists = Theorist.all
  end

  def new
    @theorist = Theorist.new
  end

  def create
    @theorist = Theorist.new(theorist_params)
    @theorist.user = current_user
    if @booking.save
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
  end

private

  def theorist_params
    params.require(:theorist).permit(:stage_name, :main_theory, :sources, :price, :location)
  end

end
