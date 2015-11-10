require 'codebreaker/guess.rb'
require 'codebreaker/code.rb'

module Codebreaker
  class Game
    
    SECRET_SIZE = 4
    MAX_ATTEMPTS = 4

    attr_writer   :secret_code
    attr_accessor :user_code
    attr_reader   :result

    def initialize
      @secret_code = ""
    end
    
    def start
      generate_secret
    end

    def generate_secret
      SECRET_SIZE.times do
        @secret_code << (Random.rand(1..6)).to_s
      end
    end
  end
end
