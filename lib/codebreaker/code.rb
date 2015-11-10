module Codebreaker
  class Code
    
    SECRET_SIZE = 4

    def initialize
      @secret_code = ""
    end

    def generate_secret
      SECRET_SIZE.times do
        @secret_code << (Random.rand(1..6)).to_s
      end
    end
  end
end