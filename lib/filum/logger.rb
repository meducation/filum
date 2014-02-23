require 'logger'

module Filum
  class Logger < ::Logger

    attr_reader :logfile
    def initialize(logfile, options = {})
      @logfile = logfile
      create_log_directory

      super(logfile, shift_age='daily')
      self.formatter = Filum::LogFormatter.new(options)
      self.level = Logger::INFO
    end

    def context_id=(context_id)
      Thread.current[:context_id] = context_id
    end

    private
    def create_log_directory
      dir = File.dirname(@logfile)
      unless File.directory?(dir)
        FileUtils.mkdir_p(dir)
      end
    end
  end
end
