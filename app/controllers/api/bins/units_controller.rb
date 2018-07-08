class Api::Bins::UnitsController < Api::BinsController
  def show
    @bin = Bin.find(params[:id])
    @bin.requested!

    respond_to do |format|
      format.json { render json: @bin.as_json, status: :ok }
      format.html { render json: @bin.as_json, status: :ok }
    end
  end
end