require File.expand_path('../../test_helper', __FILE__)

module Filum

  class IntegrationTest < Minitest::Test
    def setup
      super

      Filum.config do |config|
        config.logfile = "/tmp/filum_test_#{Time.now.to_i}.log"
      end
    end
  end
end