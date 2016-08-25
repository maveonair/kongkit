module Kongkit
  class Configuration
    attr_accessor :url

    def initialize
      @url = 'http://localhost:8001'
    end
  end
end
