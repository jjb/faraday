require 'test/unit'

if ENV['LEFTRIGHT']
  begin
    require 'leftright'
  rescue LoadError
    puts "Run `gem install leftright` to install leftright."
  end
end

require 'faraday'

begin
  require 'ruby-debug'
rescue LoadError
  # ignore
else
  Debugger.start
end

module Faraday
  class TestCase < Test::Unit::TestCase
    LIVE_SERVER = case ENV['LIVE']
      when /^http/ then ENV['LIVE']
      when nil     then nil
      else 'http://127.0.0.1:4567'
    end

    def test_default
      assert true
    end unless defined? ::MiniTest
  end
end

require 'webmock/test_unit'
WebMock.disable_net_connect!(:allow => Faraday::TestCase::LIVE_SERVER)
