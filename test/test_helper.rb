gem "minitest"
require "minitest/autorun"
require "minitest/pride"
require "minitest/mock"
require "mocha/setup"

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "filum"

class Minitest::Test
  def setup
    super
    Filum.instance_variable_set(:@logger, nil)
  end
end
