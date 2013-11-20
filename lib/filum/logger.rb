require 'logger'

module Filum
  class Logger < ::Logger
    def context_id=(context_id)
      Thread.current[:context_id] = context_id
    end

    def info(str)
      super("#{DateTime.now} thread_id-#{Thread.current.object_id} #{caller[0]} [#{Thread.current[:context_id]}] INFO | #{str}")
    end

    def fatal(str)
      super("#{DateTime.now} thread_id-#{Thread.current.object_id} #{caller[0]} [#{Thread.current[:context_id]}] FATAL | #{str}")
    end

    def error(str)
      super("#{DateTime.now} thread_id-#{Thread.current.object_id} #{caller[0]} [#{Thread.current[:context_id]}] ERROR | #{str}")
    end

    def warn(str)
      super("#{DateTime.now} thread_id-#{Thread.current.object_id} #{caller[0]} [#{Thread.current[:context_id]}] WARN | #{str}")
    end

    def debug(str)
      super("#{DateTime.now} thread_id-#{Thread.current.object_id} #{caller[0]} [#{Thread.current[:context_id]}] DEBUG | #{str}")
    end
  end
end