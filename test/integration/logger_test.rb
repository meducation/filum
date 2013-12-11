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
      Filum.logger.info "Foobar"
      assert_logged(/Foobar$/)
    end

    private
    def assert_logged(regex)
      assert File.readlines(Filum.config.logfile).grep(regex).size == 1
    end
  end

  class LogFormatterTest < IntegrationTest
    def test_string_format
      formatter = Filum::Logger::Formatter.new
      severity = "SEV123"
      timestamp = "Timestamp123"
      msg = "My Message"
      context_id = "context_id"
      object_id = Thread.current.object_id
      file_and_line = "file_and_line"
      formatter.stubs(calling_file_and_line: file_and_line)
      Thread.current[:context_id] = context_id

      output = formatter.call(severity, timestamp, nil, msg)
      desired = "#{timestamp} thread_id-#{object_id} [#{context_id}] #{severity} | #{file_and_line} | #{msg}\n"
      assert_equal desired.strip.hex, output.strip.hex
    end

    def test_call_calls_formatted_context_id
      formatter = Filum::Logger::Formatter.new
      formatter.expects(:formatted_context_id)
      formatter.call("", "", "", "")
    end

    def test_formatted_context_id_uses_config
      Filum.config.context_id_length = 20
      context_id = "12345"
      Thread.current[:context_id] = context_id
      formatter = Filum::Logger::Formatter.new
      output = formatter.send(:formatted_context_id)
      assert_equal "#{context_id}               ", output
    end

    def test_call_calls_formatted_calling_file_and_line
      formatter = Filum::Logger::Formatter.new
      formatter.expects(:formatted_calling_file_and_line)
      formatter.call("", "", "", "")
    end

    def test_call_should_not_truncate_context_id
      context_id = "context_id"
      Thread.current[:context_id] = context_id
      formatter = Filum::Logger::Formatter.new
      output = formatter.send(:formatted_context_id)
      assert_equal context_id, output
    end

    def test_call_should_return_fixed_width_context_id
      context_id = "1234"
      Thread.current[:context_id] = context_id
      formatter = Filum::Logger::Formatter.new
      output = formatter.send(:formatted_context_id)
      assert_equal "#{context_id}  ", output
    end

    def test_calling_file_and_line_parses_correctly
      formatter = Filum::Logger::Formatter.new
      line = "/Users/iHiD/Projects/meducation/filum/lib/filum/logger.rb:30:in `formatted_calling_file_and_line'"
      formatter.stubs(calling_code: line)
      output = formatter.send(:formatted_calling_file_and_line)
      assert output =~ /logger\.rb:30\s*/
    end

    def test_formatted_calling_file_and_line_uses_config
      Filum.config.filename_length = 40
      filename = "abcdefghij"
      line = "/Users/iHiD/Projects/meducation/filum/lib/filum/#{filename}:30:in `formatted_calling_file_and_line'"
      formatter = Filum::Logger::Formatter.new
      formatter.stubs(calling_code: line)
      output = formatter.send(:formatted_calling_file_and_line)
      assert_equal "#{filename}:30 #{" " * 30}", output
    end

    def test_formatted_calling_file_and_line_should_truncate
      filename = "abcdefghijklmnopqrstuvwxyz1234"
      line = "/Users/iHiD/Projects/meducation/filum/lib/filum/#{filename}:30:in `formatted_calling_file_and_line'"
      formatter = Filum::Logger::Formatter.new
      formatter.stubs(calling_code: line)
      output = formatter.send(:formatted_calling_file_and_line)
      assert_equal "abcdefghijklmnopq...:30 ", output
    end

    def test_formatted_calling_file_and_line_should_pad
      filename = "foobar.txt"
      line = "/Users/iHiD/Projects/meducation/filum/lib/filum/#{filename}:30:in `formatted_calling_file_and_line'"
      formatter = Filum::Logger::Formatter.new
      formatter.stubs(calling_code: line)
      output = formatter.send(:formatted_calling_file_and_line)
      assert_equal "foobar.txt:30           ", output
    end
  end
end
