class Api::Bins::UnitsController < Api::BinsController
  def show
    @bin = Bin.find(params[:id])

    respond_to do |format|
      @bin.requested!
      format.json { render json: @bin.as_json, status: :ok }
      format.html { render json: @bin.as_json, status: :ok }
    end
  end
end