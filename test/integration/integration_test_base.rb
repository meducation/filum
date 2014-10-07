require File.expand_path('../../test_helper', __FILE__)

module Filum

  class Worker
    def self.process
      Filum.logger.info "Processing"
    end
  end

  module IntegrationTestBase

    def test_one_logline
      test_thread = Thread.new do
        Filum.logger.context_id = "123456"
        Worker.process
      end
      test_thread.join
      assert_logged(/\[123456\]/)
    end

    def test_multiple_threads
      test_thread1 = Thread.new do
        Filum.logger.context_id = "23456a"
        Worker.process
      end
      test_thread2 = Thread.new do
        Filum.logger.context_id = "34567a"
        Worker.process
      end
      test_thread1.join
      test_thread2.join
      assert_logged(/\[23456a\]/)
      assert_logged(/\[34567a\]/)
    end

    def test_info_string_is_correct
      random_string = [*'a'..'z'].sample(10).join
      Filum.logger.info "Foobar #{random_string}"
      assert_logged(/Foobar #{random_string}$/)
    end

    def test_caller_line_is_correct
      expected_file = 'integration_test_...'
      expected_line = __LINE__+1
      Filum.logger.info "Foobar"
      assert_logged(/#{expected_file}:#{expected_line}/)
    end

    def test_log_timings
      expected_file = 'integration_test_...'
      Filum.logger.start_timing 'Foo'
      Filum.logger.end_timing 'Foo'

      assert_logged(/Started timing for Foo/)
      assert_logged(/Stopped timing for Foo/)
    end

  end
end
