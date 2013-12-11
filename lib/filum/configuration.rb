module Filum

  class FilumConfigurationError < FilumError
  end

  class Configuration

    SETTINGS = [ :logfile, :context_id_length, :filename_length ]
    attr_accessor *SETTINGS

    def initialize
      self.context_id_length = 6
      self.filename_length   = 20
    end

  end
end

