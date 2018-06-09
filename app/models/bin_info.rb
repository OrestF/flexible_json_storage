class BinInfo
  include Mongoid::Document

  belongs_to :bin

  field :ip_address, type: String
  field :request_count, type: Integer, default: 0
  field :created_at, type: DateTime, default: Time.current
  field :updated_at, type: DateTime, default: Time.current
end
