require 'logger'

module Filum
  class Logger < ::Logger
    def context_id=(context_id)
      Thread.current[:context_id] = context_id
    end

    def info(str)
      super("#{DateTime.now}#{Thread.current[:context_id]} #{str}")
    end

    def fatal(str)
      super("#{DateTime.now}#{Thread.current[:context_id]} #{str}")
    end

    def error(str)
      super("#{DateTime.now}#{Thread.current[:context_id]} #{str}")
    end

    def warn(str)
      super("#{DateTime.now}#{Thread.current[:context_id]} #{str}")
    end

    def debug(str)
      super("#{DateTime.now}#{Thread.current[:context_id]} #{str}")
    end
  end
end