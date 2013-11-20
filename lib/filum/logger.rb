require 'logger'

module Filum
  class Logger < ::Logger
    def context_id=(context_id)
      Thread.current[:context_id] = context_id
    end

    def info(str)
      super(format("INFO", str))
    end

    def fatal(str)
      super(format("FATAL", str))
    end

    def error(str)
      super(format("ERROR", str))
    end

    def warn(str)
      super(format("WARN", str))
    end

    def debug(str)
      super(format("DEBUG", str))
    end

    private
    def fromat(level, str)
      "#{DateTime.now} thread_id-#{Thread.current.object_id} #{caller[0]} [#{Thread.current[:context_id]}] #{level} | #{str}"
    end
  end
end