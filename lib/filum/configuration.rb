module Filum

  class FilumConfigurationError < FilumError
  end

  class Configuration

    SETTINGS = [
      :logfile
    ]
    attr_accessor *SETTINGS

  end
end

