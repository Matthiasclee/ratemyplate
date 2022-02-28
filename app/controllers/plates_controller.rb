class PlatesController < ApplicationController
  before_action :set_plate, only: %i[ show edit update destroy ]

  # GET /plates or /plates.json
  def index
    allowed_sorts = [:score, :score_least, :newest, :oldest]
    @sort_by = :score
    @sort_by = params[:sort_by].to_sym if params[:sort_by] && allowed_sorts.include?(params[:sort_by].to_sym)
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
    @plate = Plate.find_by(id: params[:id])
    @plate.score = @plate.score + 1
    @plate.save
    head :ok
  end

  # POST /plates or /plates.json
  def create
    @plate = Plate.new(plate_params.except(:image))
    @plate.score = 0
    @plate.plate = @plate.plate.gsub("0", "O")

    if plate_params[:image]
      file_id = (('a'..'z').to_a + (0..9).to_a + ('A'..'Z').to_a).shuffle[0..50].join
      File.write(Rails.root.join('public', 'uploads', plate_params[:image].original_filename + file_id), plate_params[:image].read, mode: 'wb')
      @plate.imageurl = "static?filename=" + plate_params[:image].original_filename + file_id
    end

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
      params.require(:plate).permit(:plate, :state, :image, :sort_by)
    end
end
