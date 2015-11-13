module Codebreaker

  class Guess

    attr_accessor :value
    
    def initialize value
      @value = value
    end

    def valid?
      @value =~ /^[1-6]{4}$/
    end
  end
end
