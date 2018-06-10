class BinCollection
  include Mongoid::Document

  has_many :bins

  field :name, type: String
  field :ip_address, type: String
  field :request_count, type: Integer, default: 0
  field :created_at, type: DateTime, default: DateTime.current
  field :updated_at, type: DateTime, default: DateTime.current

  def requested!
    update(request_count: self.request_count += 1)
  end
end
