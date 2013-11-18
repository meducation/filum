require "filum/version"

module Filum

  def self.logger
    logger ||= Filum::Logger.new('log/filum.log')
    logger.level = Logger::INFO
    logger
  end

end
