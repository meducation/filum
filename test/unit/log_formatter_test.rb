require File.expand_path('../../test_helper', __FILE__)

module Filum
  
  class LogFormatterTest < Minitest::Test
    
    def test_string_format_contains_correct_when_padding_stripped_out
      formatter = Filum::LogFormatter.new
      severity = "SEV123"
      timestamp = "Timestamp123"
      msg = "My Message"
      context_id = "context_id"
      object_id = Thread.current.object_id
      file_and_line = "file_and_line"
      formatter.stubs(formatted_calling_file_and_line: file_and_line)
      Thread.current[:context_id] = context_id

      output = formatter.call(severity, timestamp, nil, msg)
      desired = "#{timestamp} t-#{object_id} [#{context_id}] #{severity} | #{file_and_line} | #{msg}\n"
      assert_equal desired, output.gsub(/[ ]+/, ' ')
    end
    
    def test_severity_should_pad_to_5_chars
      formatter = Filum::LogFormatter.new
      severity = "SEV"
      timestamp = "Timestamp123"
      msg = "My Message"
      output = formatter.call(severity, timestamp, nil, msg)
      actual_severity_field = output.match(/SEV\s+\|/)[0]
      assert_equal "SEV   |", actual_severity_field
    end
    
    def test_can_format_with_nil_severity
      formatter = Filum::LogFormatter.new
      formatter.call(nil, "timestamp", nil, "msg")
    end
    
    def test_can_format_with_nil_timestamp
      formatter = Filum::LogFormatter.new
      formatter.call("SEV", nil, nil, "msg")
    end
    
    def test_can_format_with_nil_msg
      formatter = Filum::LogFormatter.new
      formatter.call("SEV", "timestamp", nil, nil)
    end

    def test_call_calls_formatted_context_id
      formatter = Filum::LogFormatter.new
      formatter.expects(:formatted_context_id)
      formatter.call("", "", "", "")
    end

    def test_formatted_context_id_uses_config
      Filum.config.context_id_length = 20
      context_id = "12345"
      Thread.current[:context_id] = context_id
      formatter = Filum::LogFormatter.new
      output = formatter.send(:formatted_context_id)
      assert_equal "#{context_id}               ", output
    end

    def test_call_calls_formatted_calling_file_and_line
      formatter = Filum::LogFormatter.new
      formatter.expects(:formatted_calling_file_and_line)
      formatter.call("", "", "", "")
    end

    def test_call_should_not_truncate_context_id
      context_id = "context_id"
      Thread.current[:context_id] = context_id
      formatter = Filum::LogFormatter.new
      output = formatter.send(:formatted_context_id)
      assert_equal context_id, output
    end

    def test_call_should_return_fixed_width_context_id
      context_id = "1234"
      Thread.current[:context_id] = context_id
      formatter = Filum::LogFormatter.new
      output = formatter.send(:formatted_context_id)
      assert_equal "#{context_id}  ", output
    end

    def test_calling_file_and_line_parses_correctly
      formatter = Filum::LogFormatter.new
      line = "/Users/iHiD/Projects/meducation/filum/lib/filum/logger.rb:30:in `formatted_calling_file_and_line'"
      formatter.stubs(calling_code: line)
      output = formatter.send(:formatted_calling_file_and_line)
      assert output =~ /logger\.rb:30\s*/
    end

    def test_formatted_calling_file_and_line_uses_config
      Filum.config.filename_length = 40
      filename = "abcdefghij"
      line = "/Users/iHiD/Projects/meducation/filum/lib/filum/#{filename}:30:in `formatted_calling_file_and_line'"
      formatter = Filum::LogFormatter.new
      formatter.stubs(calling_code: line)
      output = formatter.send(:formatted_calling_file_and_line)
      assert_equal "#{filename}:30 #{" " * 30}", output
    end

    def test_formatted_calling_file_and_line_should_truncate
      filename = "abcdefghijklmnopqrstuvwxyz1234"
      line = "/Users/iHiD/Projects/meducation/filum/lib/filum/#{filename}:30:in `formatted_calling_file_and_line'"
      formatter = Filum::LogFormatter.new
      formatter.stubs(calling_code: line)
      output = formatter.send(:formatted_calling_file_and_line)
      assert_equal "abcdefghijklmnopq...:30 ", output
    end

    def test_formatted_calling_file_and_line_should_pad
      filename = "foobar.txt"
      line = "/Users/iHiD/Projects/meducation/filum/lib/filum/#{filename}:30:in `formatted_calling_file_and_line'"
      formatter = Filum::LogFormatter.new
      formatter.stubs(calling_code: line)
      output = formatter.send(:formatted_calling_file_and_line)
      assert_equal "foobar.txt:30           ", output
    end
    
    def test_call_calls_formatted_thread_id
      formatter = Filum::LogFormatter.new
      formatter.expects(:formatted_thread_id)
      formatter.call("", "", "", "")
    end
    
    def test_formatted_thread_id_should_pad
      formatter = Filum::LogFormatter.new
      formatter.stubs(thread_id: "0123456")
      output = formatter.send(:formatted_thread_id)
      assert_equal "t-0123456   ", output
    end
    
    def test_formatted_thread_id_should_overflow_not_trim
      formatter = Filum::LogFormatter.new
      formatter.stubs(thread_id: "01234567890")
      output = formatter.send(:formatted_thread_id)
      assert_equal "t-01234567890", output
    end
    
  end
end