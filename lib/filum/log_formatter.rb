require 'logger'

module Filum
  class LogFormatter < Logger::Formatter
    def call(severity, timestamp, progname, msg)
      "#{timestamp} thread_id-#{Thread.current.object_id} [#{formatted_context_id}] #{severity} | #{formatted_calling_file_and_line} | #{msg}\n"
    end

    private
    def formatted_context_id
      context_id.ljust(Filum.config.context_id_length)
    end

    def context_id
      Thread.current[:context_id].to_s
    end

    def formatted_calling_file_and_line
      filename_length = Filum.config.filename_length
      truncated_filename_length = filename_length - 3

      _, file, line = calling_code.match(/([\w\.]+)\:(\d+)\:in /).to_a
      file = "#{file[0,truncated_filename_length]}..." if file.length >= filename_length 
      "#{file}:#{line.ljust(3)}".ljust(filename_length + 4)
    end

    def calling_code
      caller[4]
    end
  end
end
