class PlatesController < ApplicationController
  before_action :set_plate, only: %i[ show edit update destroy ]

  # GET /plates or /plates.json
  def index
    allowed_sorts = [:score, :score_least, :newest, :oldest]

    states = %w(AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY)
    scopes = [:all] + states

    @sort_by = :score
    @sort_by = params[:sort_by].to_sym if params[:sort_by] && allowed_sorts.include?(params[:sort_by].to_sym)

    @scope = :all
    @scope = params[:scope].to_sym if params[:scope] && scopes.include?(params[:scope])

    @query = ""
    @query = params[:query].upcase.gsub("0", "O") if params[:query]

    @plates = Plate.all if @scope == :all
    @plates = Plate.where(state: @scope) if @scope != :all

    @plates = @plates.where("plate like?", "%#{@query}%")
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
    @plate.plate = @plate.plate.gsub("0", "O").upcase

    if plate_params[:image]
      File.write(Rails.root.join("tmpimg"), plate_params[:image].read, mode: "wb")
      @plate.image = File.read("tmpimg")
    end

    respond_to do |format|
      if @plate.save
        @plate.imageurl = @plate.imageurl = "static?id=" + @plate.id.to_s
        @plate.save
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
      params.require(:plate).permit(:plate, :state, :image, :sort_by, :scope, :query)
    end
end
