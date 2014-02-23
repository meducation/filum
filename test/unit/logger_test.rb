require File.expand_path('../../test_helper', __FILE__)

module Filum
  class FilumTest < Minitest::Test
    def test_initializer_stores_logfile
      logfile = "./log/test.log"
      logger = Filum::Logger.new(logfile)
      assert_equal logfile, logger.logfile
    end

    def test_initializer_proxies_to_formatter_correctly
      options = {foo: 'bar'}
      Filum::LogFormatter.expects(:new).with(options)
      Filum::Logger.new("./log/test.log", options)
    end

    def test_initializer_sets_level
      logger = Filum::Logger.new("./log/test.log")
      assert_equal Logger::INFO, logger.level
    end
  end
end
