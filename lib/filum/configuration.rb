module Filum

  class FilumConfigurationError < FilumError
  end

  class Configuration

    SETTINGS = [
      :logger
    ]
    attr_writer *SETTINGS

    def initialize
      self.logger = Filum::Logger.new
    end

  end
end

