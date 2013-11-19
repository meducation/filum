require File.expand_path('../../test_helper', __FILE__)

module Filum
  class ConfigurationTest < Minitest::Test

    def setup
      Filum.instance_variable_set("@config", nil)
    end

    def test_obtaining_singletion
      refute Filum.config.nil?
    end

    def test_block_syntax
      test_logfile = "/tmp/filum.log"
      Filum.config do |config|
        config.logfile = test_logfile
      end
      assert_equal test_logfile, Filum.config.logfile
    end

    def test_logfile
      test_logfile = "/tmp/filum.log"
      Filum.config.logfile = test_logfile
      assert_equal test_logfile, Filum.config.logfile
    end
  end
end

