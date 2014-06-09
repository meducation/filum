require_relative 'integration_test_base'

module Filum

  class StdOutLoggerTest < Minitest::Test
    include IntegrationTestBase

    def setup
      super

      @filename = "/tmp/log/filum_stdout_test_#{Time.now.to_i}.log"
      $stdout.expects(:write).at_least_once.with do |data|
        File.open(@filename, "a") do |file|
          file.write(data)
        end
      end

      Filum.setup($stdout)
    end

    def teardown
      super
      mocha_teardown
    end

    def assert_logged(regex)
      assert File.readlines(@filename).grep(regex).size == 1
    end
  end
end

