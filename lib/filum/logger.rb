require 'logger'

module Filum
  class Logger < ::Logger

    module Severity
      VERBOSE = 6
    end
    SEV_LABEL << "VERB"

    def initialize(*args)
      super
      self.formatter = Filum::LogFormatter.new
    end

    def verbose(progname = nil, &block)
      add(Severity::VERBOSE, nil, progname, &block)
    end

    def context_id=(context_id)
      Thread.current[:context_id] = context_id
    end
  end
end
