require File.expand_path('../../test_helper', __FILE__)

module Filum
  class FilumTest < Minitest::Test
    def test_setup_proxies_correctly
      logfile = "foobar"
      options = {foo: 'bar'}
      Filum::Logger.expects(:new).with(logfile, options)
      Filum.setup(logfile, options)
    end

    def test_logger_returns_logger
      logfile = "./log/test.log"
      logger = Filum.setup(logfile)
      assert_equal logger, Filum.logger
    end

    def test_call_to_loquor_without_setup_raises
      assert_raises(FilumError) do
        Filum.logger
      end
    end
  end
end
