module Mutators
  module Bin
    class Create
      def initialize(params, service_params = {})
        @params = params
        @service_params = service_params
      end

      def invoke
        @bin = ::Bin.new(@params)
        create_bin_info if @bin.save

        @bin
      end

      private

      def create_bin_info
        ::BinInfo.create(bin: @bin, ip_address: @service_params[:ip_address])
      end
    end
  end
end

