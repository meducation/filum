require File.expand_path('../../test_helper', __FILE__)

module Filum

  class Worker
    def self.process
      Filum.logger.info "Processing"
    end
  end

  class LoggerTest < IntegrationTest
    def test_one_logline
      test_thread = Thread.new do
        Filum.logger.context_id = " [12345]"
        Worker.process
      end
      test_thread.join
      assert_logged(/\[12345\]/)
    end

    def test_multiple_threads
      test_thread1 = Thread.new do
        Filum.logger.context_id = " [23456]"
        Worker.process
      end
      test_thread2 = Thread.new do
        Filum.logger.context_id = " [34567]"
        Worker.process
      end
      test_thread1.join
      test_thread2.join
      assert_logged(/\[23456\]/)
      assert_logged(/\[34567\]/)
    end


    def assert_logged(regex)
      assert File.readlines(Filum.config.logfile).grep(regex).size == 1
    end
  end
end
