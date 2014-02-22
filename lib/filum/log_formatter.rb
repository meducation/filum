require 'logger'

module Filum
  class LogFormatter < Logger::Formatter
    def initialize(options = {})
      @context_id_length = options.fetch(:context_id_length, 6)
      @filename_length = options.fetch(:filename_length, 20)
    end

    def call(severity, timestamp, progname, msg)
      "#{timestamp} #{formatted_thread_id} [#{formatted_context_id}] #{severity.to_s.ljust(5)} | #{formatted_calling_file_and_line} | #{msg}\n"
    end

    private
    def formatted_context_id
      context_id.ljust(@context_id_length)
    end

    def context_id
      Thread.current[:context_id].to_s
    end

    def formatted_calling_file_and_line
      filename_length = @filename_length
      truncated_filename_length = filename_length - 3

      _, file, line = calling_code.match(/([\w\.]+)\:(\d+)\:in /).to_a
      file = "#{file[0,truncated_filename_length]}..." if file.length >= filename_length
      "#{file}:#{line.ljust(3)}".ljust(filename_length + 4)
    end

    def formatted_thread_id
      "t-#{thread_id}".ljust(12)
    end

    def calling_code
      caller[5]
    end

    def thread_id
      Thread.current.object_id
    end
  end
end
