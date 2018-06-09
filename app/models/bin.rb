class Bin
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  has_one :bin_info, dependent: :destroy

  def requested!
    bin_info.update(request_count: bin_info.request_count += 1)
  end
end
