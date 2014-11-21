class HTMLRiverParser
  def initialize(data_source)
    @data_source = data_source
  end

  def method_missing(*args, &block)
    @data_source.send(*args, &block)
  end
end
