class Api::Bins::CollectionsController < Api::BinsController
  def show
    @bins = Search::BinCollection.new(params).invoke
    @bins.last.bin_collection.requested!

    respond_to do |format|
      format.json { render json: @bins.as_json, status: :ok }
      format.html { render json: @bins.as_json, status: :ok }
    end
  end

  def search_engine
    @search_engine ||= Search::BinCollection.new(params).invoke
  end
end