require 'codebreaker/guess.rb'
require 'codebreaker/player.rb'

module Codebreaker
  class Game

    SECRET_CODE_SIZE = 4
    MAX_ATTEMPTS = 4

    attr_reader :secret, :attempts, :hints, :player
    attr_accessor :user_code

    def initialize(player)
      @player = player
      @secret = ""
      @player_code = ""
      @hints = 0
      @attempts = 0
      generate_secret
      # @secret_code = secret_code
      # @result = []
    end
    
    def start
      generate_secret
    end

    def user_code(player_code)
      guess = Codebreaker::Guess.new(player_code)
      @player_code = player_code if guess.valid?
    end

    def guess(suspect)
      result = ""
      SECRET_CODE_SIZE.times do |el|
        if @secret[el] == suspect.value[el]
          result << "+"
        elsif @secret.include? suspect.value[el]
          result << "-"
        else
          result << ""
        end
      end
      result
    end

    def generate_secret
      SECRET_CODE_SIZE.times do
        @secret << (Random.rand(1..6)).to_s
      end
    end

    def use_hint?
      @hints < 1 ? true : false
    end

    def take_hint
      if use_hint?
        @hints += 1
        @secret_code.split('')[rand(0..3)]
      end
    end
    
    def answer
      @secret
    end

    def result(suspect)
      @attempts += 1
      string = guess(suspect)
      if string == "++++"
        save_game("../../results.txt")
        p "#{@player} you win !!!"
      elsif @attempts < MAX_ATTEMPTS
        p "you have used #{@attempts} from #{MAX_ATTEMPTS} attempts"
      elsif @attempts == MAX_ATTEMPTS
        return "Game over"
      end
    end

    def save_game(file)
      File.open(file, 'w') { |f| f.puts("#{@player} guessed code.\n with #{@attempts} attempts\n and use #{@hints} hints") }
    end

    def answer
      @secret
    end
  end
end

  