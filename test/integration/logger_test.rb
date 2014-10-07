require_relative 'integration_test_base'

module Filum

  class LoggerTest < Minitest::Test
    include IntegrationTestBase
    protected

    def setup
      super
      Filum.setup("/tmp/log/filum_test_#{Time.now.to_i}.log")
    end

    def assert_logged(regex)
      lines = File.readlines(Filum.logger.logfile)
      assert lines.grep(regex).size == 1, "Pattern (#{regex}) was not found in \n#{lines.join}"
    end
  end
end
