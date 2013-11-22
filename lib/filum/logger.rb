require 'logger'

module Filum
  class Logger < ::Logger
    def context_id=(context_id)
      Thread.current[:context_id] = context_id
    end

    def info(str)
      super("#{DateTime.now} thread_id-#{Thread.current.object_id} [#{Thread.current[:context_id]}] INFO | #{str} | #{caller[0]}")
    end

    def fatal(str)
      super("#{DateTime.now} thread_id-#{Thread.current.object_id} [#{Thread.current[:context_id]}] FATAL | #{str} | #{caller[0]}")
    end

    def error(str)
      super("#{DateTime.now} thread_id-#{Thread.current.object_id} [#{Thread.current[:context_id]}] ERROR | #{str} | #{caller[0]}")
    end

    def warn(str)
      super("#{DateTime.now} thread_id-#{Thread.current.object_id} [#{Thread.current[:context_id]}] WARN | #{str} | #{caller[0]}")
    end

    def debug(str)
      super("#{DateTime.now} thread_id-#{Thread.current.object_id} [#{Thread.current[:context_id]}] DEBUG | #{str} | #{caller[0]}")
    end
  end
end