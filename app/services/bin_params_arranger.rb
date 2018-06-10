class BinParamsArranger
  def initialize(params)
    @params = params
  end

  def prepare
    permit
    filter
    extract_data
  end

  private

  def permit
    @params.permit!
  end

  def filter
    @params = @params.except(:controller, :action)
  end

  def extract_data
    @params[:content]
  end
end