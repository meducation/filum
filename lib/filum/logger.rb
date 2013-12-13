require 'logger'

module Filum
  class Logger < ::Logger

    def initialize(*args)
      super
      self.formatter = Filum::LogFormatter.new
    end

    def context_id=(context_id)
      Thread.current[:context_id] = context_id
    end
  end
end
