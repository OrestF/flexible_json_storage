class JsonCop
  def initialize(data)
    @data = data
  end

  def self.generate
    new(data).send(:generate_json)
  end

  def self.parse(data)
    new(data).send(:parse_json)
  end

  def self.valid?(data)
    new(data).send(:check_validness)
  end

  private

  def check_validness
    Oj.load(@data).present? ? true : false
  rescue Oj::ParseError
    false
  end

  def parse_json
    Oj.load(@data)
  end

  def generate_json
    Oj.dump(@data)
  end
end
