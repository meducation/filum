require 'logger'

module Filum
  class Logger < ::Logger


    attr_reader :logfile

    def initialize(logfile, options = {})
      @timings = {}
      @logfile = logfile
      create_log_directory

      super(logfile, shift_age='daily')
      self.formatter = Filum::LogFormatter.new(options)
      self.level = Logger::INFO
    end

    def context_id=(context_id)
      Thread.current[:context_id] = context_id
    end

    def start_timing(label)
      @timings[label] = Time.now
      info("Started timing for #{label} at #{@timings[label]}")
    end

    def end_timing(label)
      finish = Time.now
      if @timings[label]
        info("Stopped timing for #{label} at #{@timings[label]}, #{(finish.to_f - @timings[label].to_f).round(3)}")
      else
        info("Stopped timing for #{label} at #{@timings[label]}, no start time found")
      end
    end

    private
    def create_log_directory
      return unless @logfile.is_a?(String)
      dir = File.dirname(@logfile)
      unless File.directory?(dir)
        FileUtils.mkdir_p(dir)
      end
    end
  end
end
