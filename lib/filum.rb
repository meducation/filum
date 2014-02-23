require "filum/version"
require "filum/filum_error"
require "filum/log_formatter"
require "filum/logger"

module Filum

  # Filum setup method
  #
  # This must be called before Filum.logger is used.
  #
  # Options can be
  # * <tt>:config.context_id_length</tt> Defaults to 6
  # * <tt>:filename_length</tt> Defaults to 20
  #
  def self.setup(logfile, options = {})
    @logger = Filum::Logger.new(logfile, options)
  end

  # Filum logger.
  #
  # Logger. Log in the following way:
  #
  #   Filum.logger.info "Log this"
  #
  def self.logger
    raise FilumError.new("Filum is not setup. Please call Filum#setup") unless @logger
    @logger
  end
end
