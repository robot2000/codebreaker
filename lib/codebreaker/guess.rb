module Codebreaker
  
  class Guess
    
    attr_accessor :code
    
    def initialize(code = nil)
      @code = code
    end

    def valid?
      @code =~ /^[1-6]{4}$/
    end
  end
end