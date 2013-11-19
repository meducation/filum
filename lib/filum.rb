require "filum/version"
require "filum/filum_error"
require "filum/configuration"
require "filum/logger"

module Filum

  # Filum configuration settings.
  #
  # Settings should be set in an initializer or using some
  # other method that insures they are set before any
  # Filum code is used. They can be set as followed:
  #
  #   Filum.config.logfile = "/var/log/mylogfile.log"
  #
  # The following settings are allowed:
  #
  # * <tt>:logfile</tt> - The logfile
  def self.config
    @config ||= Configuration.new
    if block_given?
      yield @config
    else
      @config
    end
  end

  # Filum logger.
  #
  # Logger. Log in the following way:
  #
  #   Filum.logger.info "Log this"
  #
  def self.logger
    @logger ||= Filum::Logger.new(Filum.config.logfile)
    @logger.level = Logger::INFO
    @logger
  end

end
