require File.expand_path('../../test_helper', __FILE__)

module Filum

  class Worker
    def self.process
      Filum.logger.info "Processing"
    end
  end

  class LoggerTest < IntegrationTest
    def test_one_logline
      out, err = capture_io do
      #assert_output(" [12345] Processing") do
        test_thread = Thread.new do
          Thread.current[:context_id] = " [12345]"
          Worker.process
        end
        test_thread.join
      end
      assert_equal " [12345] Processing", out
      assert out.include? " [12345] Processing"
    end
  end
end
