require 'logger'

module Filum
  class Logger < ::Logger
    def context_id=(context_id)
      Thread.current[:context_id] = context_id
    end

    def info(str)
      super("#{DateTime.now} thread_id-#{Thread.current.object_id} [#{Thread.current[:context_id]}] INFO | #{calling_file_and_line} | #{str}")
    end

    def fatal(str)
      super("#{DateTime.now} thread_id-#{Thread.current.object_id} [#{Thread.current[:context_id]}] FATAL | #{calling_file_and_line} | #{str}")
    end

    def error(str)
      super("#{DateTime.now} thread_id-#{Thread.current.object_id} [#{Thread.current[:context_id]}] ERROR | #{calling_file_and_line} | #{str}")
    end

    def warn(str)
      super("#{DateTime.now} thread_id-#{Thread.current.object_id} [#{Thread.current[:context_id]}] WARN | #{calling_file_and_line} | #{str}")
    end

    def debug(str)
      super("#{DateTime.now} thread_id-#{Thread.current.object_id} [#{Thread.current[:context_id]}] DEBUG | #{calling_file_and_line} | #{str}")
    end
    
    def calling_file_and_line
      caller[1].match(/([\w\.]+\:\d+)\:in /)
    end
  end
end