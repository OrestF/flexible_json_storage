module Search
  class BinCollection
    def initialize(params)
      @params = params.permit!
      @query = @params[:q]
    end

    def invoke
      return bin_collection.bins if @query.blank?

      bin_collection.bins.where(generate_search_query)
    end

    private

    def generate_search_query
      @query.to_h.each_with_object({}) do |(key, value), search_query|
        search_query[key.to_sym] = prepare_value(value)
      end
    end

    def bin_collection
      @bin_collection ||= ::BinCollection.find(@params[:id])
    end

    def prepare_value(value)
      byebug
      return value unless number?(value.to_s)

      { '$in' => [value, value.to_i] }
    end

    def number?(value)
      value !~ /\D/
    end
  end
end