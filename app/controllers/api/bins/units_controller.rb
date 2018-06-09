class Api::Bins::UnitsController < Api::BinsController
  def show
    @bin = Bin.find_by(id: bin_id)

    respond_to do |format|
      @bin.requested!
      format.json { render json: @bin.as_json(except: :_id), status: :ok }
      format.html { render json: @bin.as_json(except: :_id), status: :ok }
    end
  end

  def create
    @bin = Mutators::Bin::Create.new(new_bin_params, ip_address: request.ip).invoke

    respond_to do |format|
      if @bin
        format.json { render json: { url: api_bins_unit_url(@bin) }, status: :created }
        format.html { render json: { url: api_bins_unit_url(@bin) }, status: :created }
      else
        format.json { render json: @bin.errors, status: :unprocessable_entity }
        format.html { render json: @bin.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def bin_id
    params[:id]
  end

  def new_bin_params
    BinParamsArranger.new(params).prepare
  end
end