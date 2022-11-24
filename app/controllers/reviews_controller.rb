class ReviewsController < ApplicationController

  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.theorist = Theorist.find(params[:theorist_id])
    if @review.save
      redirect_to theorist_path(@review.theorist)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    edit
    @review = Review.update(review_params)
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to theorist_path, status: :see_other
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating, :booking_date)
  end
end
