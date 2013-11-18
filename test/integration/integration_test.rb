require File.expand_path('../../test_helper', __FILE__)

module Filum

  class Worker
    def self.process
      Filum.logger.info "Processing"
    end
  end

  class IntegrationTest < Minitest::Test
    def test_one
      test_thread = Thread.new do
        Thread.current[:context_id] = " [12345]"
        Worker.process
      end
      test_thread.join
    end
  end
end
