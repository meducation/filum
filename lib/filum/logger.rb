module Filum
  class Logger < ::Logger
    def info(str)
      super("#{DateTime.now}#{Thread.current[:context_id]} #{str}")
    end
  end
end