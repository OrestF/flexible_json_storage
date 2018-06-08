class Api::BinsController < ApplicationController
  before_action :set_api_bin, only: [:show, :edit, :update, :destroy]

  # GET /api/bins
  # GET /api/bins.json
  def index
    @api_bins = Api::Bin.all
  end

  # GET /api/bins/1
  # GET /api/bins/1.json
  def show
  end

  # GET /api/bins/new
  def new
    @api_bin = Api::Bin.new
  end

  # GET /api/bins/1/edit
  def edit
  end

  # POST /api/bins
  # POST /api/bins.json
  def create
    @api_bin = Api::Bin.new(api_bin_params)

    respond_to do |format|
      if @api_bin.save
        format.html { redirect_to @api_bin, notice: 'Bin was successfully created.' }
        format.json { render :show, status: :created, location: @api_bin }
      else
        format.html { render :new }
        format.json { render json: @api_bin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/bins/1
  # PATCH/PUT /api/bins/1.json
  def update
    respond_to do |format|
      if @api_bin.update(api_bin_params)
        format.html { redirect_to @api_bin, notice: 'Bin was successfully updated.' }
        format.json { render :show, status: :ok, location: @api_bin }
      else
        format.html { render :edit }
        format.json { render json: @api_bin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/bins/1
  # DELETE /api/bins/1.json
  def destroy
    @api_bin.destroy
    respond_to do |format|
      format.html { redirect_to api_bins_url, notice: 'Bin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_bin
      @api_bin = Api::Bin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_bin_params
      params.fetch(:api_bin, {})
    end
end
