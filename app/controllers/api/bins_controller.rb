class Api::BinsController < ApiController
  before_action :set_bin, only: [:show, :edit, :update, :destroy]

  # GET /api/bins
  # GET /api/bins.json
  def index
    @bins = Bin.all
  end

  # GET /api/bins/1
  # GET /api/bins/1.json
  def show
  end

  # GET /api/bins/new
  def new
    @bin = Bin.new
  end

  # GET /api/bins/1/edit
  def edit
  end

  # POST /api/bins
  # POST /api/bins.json
  def create
    @bin = Bin.new(bin_params)

    respond_to do |format|
      if @bin.save
        format.html { redirect_to api_bin_path(@bin), notice: 'Bin was successfully created.' }
        format.json { render :show, status: :created, location: api_bin_path(@bin) }
      else
        format.html { render :new }
        format.json { render json: @bin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/bins/1
  # PATCH/PUT /api/bins/1.json
  def update
    respond_to do |format|
      if @bin.update(bin_params)
        format.html { redirect_to api_bin_path(@bin), notice: 'Bin was successfully updated.' }
        format.json { render :show, status: :ok, location: api_bin_path(@bin) }
      else
        format.html { render :edit }
        format.json { render json: @bin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/bins/1
  # DELETE /api/bins/1.json
  def destroy
    @bin.destroy
    respond_to do |format|
      format.html { redirect_to api_bins_url, notice: 'Bin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bin
      @bin = Bin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bin_params
      # params.fetch(:bin, {})
      # params

      params.permit!
      filtered_params = params.except(:controller, :action)
      byebug
      # parsed_params = JSON.parse(filtered_params)
      parsed_params = filtered_params.keys.map { |k| JSON.parse(k) }
      unlocked_params = ActiveSupport::HashWithIndifferentAccess.new(parsed_params[0])
      unlocked_params
    end
end
