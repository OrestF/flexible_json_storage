module Mutators
  module Bin
    class Create
      def initialize(params, service_params = {})
        @params = params
        @service_params = service_params
      end

      def invoke
        if @params.is_a? Array
          create_bin_collection
          return @bin_collection if @bin_collection.errors.any?

          @params.each do |params|
            @bin_collection.bins.push(create_bin(params))
          end

          @bin_collection
        else
          create_bin(@params)
        end
      end

      private

      def create_bin_info(bin)
        ::BinInfo.create(bin: bin, ip_address: @service_params[:ip_address])
      end

      def create_bin(params)
        bin = ::Bin.new(params)
        create_bin_info(bin) if bin.save

        bin
      end

      def create_bin_collection
        @bin_collection = ::BinCollection.create(ip_address: @service_params[:ip_address])
      end
    end
  end
end

