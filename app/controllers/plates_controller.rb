class PlatesController < ApplicationController
  before_action :set_plate, only: %i[ show edit update destroy ]

  # GET /plates or /plates.json
  def index
    @plates = Plate.all
  end

  # GET /plates/1 or /plates/1.json
  def show
  end

  # GET /plates/new
  def new
    @plate = Plate.new
  end

  def up
    @plate = Plate.find_by(params[:id])
    @plate.score = @plate.score + 1
    @plate.save
    redirect_to plate_path
  end

  # POST /plates or /plates.json
  def create
    @plate = Plate.new(plate_params)
    @plate.score = 0

    respond_to do |format|
      if @plate.save
        format.html { redirect_to plate_url(@plate), notice: "Plate was successfully created." }
        format.json { render :show, status: :created, location: @plate }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @plate.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plate
      @plate = Plate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def plate_params
      params.require(:plate).permit(:plate, :state)
    end
end
