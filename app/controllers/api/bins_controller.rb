class Api::BinsController < ApiController
  def create
    @result = Mutators::Bin::Create.new(new_bin_params, ip_address: request.ip).invoke

    response_for(@result)
  end

  private

  def new_bin_params
    BinParamsArranger.new(params).prepare
  end

  def response_for(item)
    url = generate_url

    respond_to do |format|
      if item.errors.none?
        format.json { render json: { url: url }, status: :created }
        format.html { render json: { url: url }, status: :created }
      else
        format.json { render json: item.errors, status: :unprocessable_entity }
        format.html { render json: item.errors, status: :unprocessable_entity }
      end
    end
  end

  def generate_url
    case @result.class
    when Bin
      api_bins_unit_url(@result)
    when BinCollection
      api_bins_collection_url(@result)
    end
  end
end
