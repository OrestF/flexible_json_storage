class Bin
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  has_one :bin_info, dependent: :destroy
  belongs_to :bin_collection, optional: true

  def requested!
    bin_info.update(request_count: bin_info.request_count += 1)
  end


  def as_json(*)
    super.except('_id', 'id', 'bin_collection_id')
  end
end
