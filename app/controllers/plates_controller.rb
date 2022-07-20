class PlatesController < ApplicationController
  before_action :set_plate, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token
  ITEMS_PER_PAGE = 25

  # GET /plates or /plates.json
  def index
    allowed_sorts = [:score, :score_least, :newest, :oldest]

    states = %w(AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY)
    scopes = [:all] + states

    @sort_by = :newest
    @sort_by = params[:sort_by].to_sym if params[:sort_by] && allowed_sorts.include?(params[:sort_by].to_sym)

    @scope = :all
    @scope = params[:scope].to_sym if params[:scope] && scopes.include?(params[:scope])

    @query = ""
    @query = params[:query].upcase.gsub("0", "O") if params[:query]

    @plates = Plate.all

    @plates = @plates.where("meaning ~* ?", @query)

    @plates_sorted = @plates.sort_by(&:score).reverse if @sort_by == :score
    @plates_sorted = @plates.sort_by(&:score) if @sort_by == :score_least
    @plates_sorted = @plates.sort_by(&:created_at).reverse if @sort_by == :newest
    @plates_sorted = @plates.sort_by(&:created_at) if @sort_by == :oldest
    @plates = @plates_sorted

    @original_page = 1
    @original_page = params[:page].to_i if params[:page].to_i > 0

    @page = 0
    @page = ((params[:page].to_i - 1) * ITEMS_PER_PAGE) if params[:page].to_i > 0

    @plates = @plates[@page..@page + ITEMS_PER_PAGE - 1].to_a
  end

  # GET /plates/1 or /plates/1.json
  def show
  end

  # GET /plates/new
  def new
    @plate = Plate.new
  end

  def up
    if request.xhr?
      @plate = Plate.find_by(id: params[:id])
      @plate.score = @plate.score + 1
      @plate.save
      head :ok
    else
      head 500
    end
  end

  # POST /plates or /plates.json
  def create
    render plain: params.to_s
    return
    @plate = Plate.new()
    @plate.meaning = params[:Body]
    if params[:NumMedia] == 0
      render plain: "Image not provided"
      return
    end
    @plate.twilioimage = params[:MediaUrl0]
    @plate.score = 0
    
    @plate.save
    render plain: 'Plate submitted'
  end

  def new_img
    @plate = Plate.find_by(id: params[:id])
    render partial: "plates/new_img"
  end

  def add_new_img
    @plate = Plate.find_by(id: params[:id])
    File.write(Rails.root.join("tmpimg"), plate_params[:image].read, mode: "wb")
    @plate.images << File.read("tmpimg", mode: "rb").dump
    @plate.imageurls << "/plate_img/#{@plate.id}/#{@plate.images.length-1}"
    @plate.save

    redirect_to plate_path(@plate)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plate
      @plate = Plate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def plate_params
      params.require(:plate).permit(:plate, :state, :image, :sort_by, :scope, :query, :page, :meaning)
    end
end
