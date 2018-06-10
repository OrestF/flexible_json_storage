module Search
  class BinCollection
    OPERATORS_MAPPING = { '>=' => 'gte',
                          '<=' => 'lte',
                          '>'  => 'gt',
                          '<'  => 'lt' }.freeze
    MATCHES_OPERATOR = '<>'.freeze

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
        @search_node = OpenStruct.new(query_key: key, query_value: value)
        key, value = prepare_key_value(key, value)
        search_query[key] = value
      end
    end

    def bin_collection
      @bin_collection ||= ::BinCollection.find(@params[:id])
    end

    def prepare_key_value(key, value)
      prepare_key(key, value)
      @search_node.search_value = prepare_value

      [@search_node.search_key, @search_node.search_value]
    end

    def prepare_key(key, value)
      @search_node.search_key = key.to_sym
      return if matches_query?(value)

      operators_mapping.each_key do |sign|
        if value.start_with?(sign)
          @search_node.search_key = key.to_sym.send(operators_mapping[sign])
          break
        end
      end
    end

    def matches_query?(value)
      value.start_with?(MATCHES_OPERATOR)
    end

    def operators_mapping
      { '>=' => 'gte',
        '<=' => 'lte',
        '>'  => 'gt',
        '<'  => 'lt'}
    end

    def prepare_value # (prepared_key, init_value)
      @search_node.search_value = @search_node.query_value
      strip_value
      value = @search_node.search_value
      return value.to_i                             if match_number?(@search_node.search_value, @search_node.search_key)
      return { '$in' => [value, value.to_i] }       if number?(value.to_s)
      return { '$regex' => Regexp.new(value, 'i') } if match_string?(@search_node.query_value)

      value
    end

    def strip_value
      if matches_query?(@search_node.query_value)
        @search_node.search_value = @search_node.query_value[matches_operator.size..-1]
        return
      end
      operators_mapping.each_key do |sign|
        if @search_node.query_value.start_with?(sign)
          @search_node.search_value = @search_node.query_value[sign.size..-1]
          break
        end
      end
    end

    def match_number?(value, key)
      number?(value.to_s) && key_with_operator?(key)
    end

    def match_string?(init_value)
      string?(init_value) && init_value.start_with?(MATCHES_OPERATOR)
    end

    def string?(value)
      value.is_a?(String) && !number?(value)
    end

    def number?(value)
      value !~ /\D/
    end

    def key_with_operator?(prepared_key)
      prepared_key.is_a?(Mongoid::Criteria::Queryable::Key)
    end
  end
end