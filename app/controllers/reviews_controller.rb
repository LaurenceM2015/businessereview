class ReviewsController < ApplicationController
  before_action :set_review, only: [ :edit, :update, :destroy]
  before_action :set_restaurant
  before_action :authenticate_user!
  before_action :check_user, only: [:edit, :update, :destroy]

 
  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.restaurant_id = @restaurant.id
    
   # We should also make sure that there is indeed a user who is signed in. Otherwise, this current_user keyword will lead to an error. If we go back to the Devise documentation, we’ll see that we can use this ‘before_action’ line to authenticate our user and force them to sign in if they want to write a review. Let’s copy this, add it to the top of our Controller file.
    

    respond_to do |format|
      if @review.save
        format.html { redirect_to @restaurant, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to restaurant_path(@restaurant), notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
 format.html { redirect_to restaurant_path(@restaurant), notice: 'Review was successfully destroyed.' }      
 format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end
    
    
    # fot Restaurant
    def set_restaurant
        @restaurant = Restaurant.find(params[:restaurant_id])
    end
    
    def check_user
          unless (@review.user == current_user) || (current_user.admin?)
            redirect_to root_url, alert: "Sorry, this review belongs to someone else"
          end
        end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end
