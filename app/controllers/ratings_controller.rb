class RatingsController < ApplicationController
  before_action :set_rating, only: %i[ show edit update destroy ]

  # GET /ratings or /ratings.json
  def index
    @ratings = Rating.all
  end

  # GET /ratings/1 or /ratings/1.json
  def show
  end

  # GET /ratings/new
  def new
    #@user = params[:user_id] # or @user = current_user, but you need to get a user
    #@rating = @user.rating.build
    @rating = Rating.new
    @rating = current_user.ratings.build
  end

  # GET /ratings/1/edit
  def edit
  end

  # POST /ratings or /ratings.json
  def create
    @club = Club.find(params[:club_id])
    @rating = @club.ratings.create(rating_params)

    respond_to do |format|
      if @rating.save
        format.html { redirect_to club_path(@club), notice: "Rating was successfully created." }
        format.json { render :show, status: :created, location: @rating }
      else
        #format.html { render :new, status: :unprocessable_entity }
        format.html { redirect_to club_path(@club), notice: @rating.errors.full_messages.to_sentence }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ratings/1 or /ratings/1.json
  def update
    respond_to do |format|
      if @rating.update(rating_params)
        format.html { redirect_to @rating, notice: "Rating was successfully updated." }
        format.json { render :show, status: :ok, location: @rating }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ratings/1 or /ratings/1.json
  def destroy
    @club = Club.find(params[:club_id])
    @rating = @club.ratings.find(params[:id])

    @rating.destroy
    respond_to do |format|
      format.html { redirect_to club_path(@club), notice: "Rating was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rating_params
      params.require(:rating).permit(:general_rating, :description, :club_id)
    end
end
