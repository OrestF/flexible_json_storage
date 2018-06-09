class BinParamsArranger
  def initialize(params)
    @params = params
  end

  def prepare
    permit
    filter
    parse
  end

  private

  def permit
    @params.permit!
  end

  def filter
    @params = @params.except(:controller, :action)
  end

  def parse
    @parsed_params = @params.keys.map { |k| JSON.parse(k) }[0]
  end

  # def unlock
  #   ActiveSupport::HashWithIndifferentAccess.new(@parsed_params)
  # end
end