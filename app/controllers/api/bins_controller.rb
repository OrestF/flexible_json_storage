class Api::BinsController < ApiController
    def create
    @result = Mutators::Bin::Create.new(new_bin_params, ip_address: request.ip).invoke

    case @result.class
    when Bin
      create_response_for_bin(@result)
    when BinCollection
      create_response_for_bin_collection(@result)
    end
  end

  private
  def new_bin_params
    BinParamsArranger.new(params).prepare
  end

  def create_response_for_bin(bin)
    respond_to do |format|
      if bin.errors.none?
        format.json { render json: { url: api_bins_unit_url(bin) }, status: :created }
        format.html { render json: { url: api_bins_unit_url(bin) }, status: :created }
      else
        format.json { render json: bin.errors, status: :unprocessable_entity }
        format.html { render json: bin.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_response_for_bin_collection(bin_collection)
    respond_to do |format|
      if bin_collection.errors.none?
        format.json { render json: { url: api_bins_collection_url(bin_collection) }, status: :created }
        format.html { render json: { url: api_bins_collection_url(bin_collection) }, status: :created }
      else
        format.json { render json: bin_collection.errors, status: :unprocessable_entity }
        format.html { render json: bin_collection.errors, status: :unprocessable_entity }
      end
    end
  end
end
