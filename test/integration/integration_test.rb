require File.expand_path('../../test_helper', __FILE__)

module Filum

  class IntegrationTest < Minitest::Test
    def setup
      super

      Filum.config do |config|
        #config.logfile = "/tmp/filum_test_#{Time.now.to_i}.log"
        logger = Logger.new(STDOUT)
        logger.level = Logger::INFO
        config.logger = logger
      end
    end
  end
end