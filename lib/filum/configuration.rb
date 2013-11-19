module Filum

  class FilumConfigurationError < FilumError
  end

  class Configuration

    SETTINGS = [
      :logfile,
      :logger
    ]
    attr_accessor *SETTINGS

  end
end

