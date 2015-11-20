module Codebreaker
  class Game
    
    SECRET_CODE_SIZE = 4
    MAX_SCORE = 10
    MAX_ROUNDS = 10
    ROUND_PENALTY = 10
    HINT = 5

    attr_reader :round_number, :guess, :game_status, :hint_value

    def initialize
      @secret = ''
      @round_number = 0
      @guess = {}
      @game_status = 'play'
      @hint_value = ''
    end
 
    def start
      SECRET_CODE_SIZE.times do
        @secret << (Random.rand(1..6)).to_s
      end
    end

    def check (suspect)
      
      raise ArgumentError, 'length must be equal 4' unless suspect.to_s.size == SECRET_CODE_SIZE
      raise ArgumentError, 'must contain only numbers from 1 to 6' unless suspect.to_s[/[1-6]+/].size == SECRET_CODE_SIZE
      
      plus  = ''
      minus = '' 
      secret_array = @secret.split('')
      suspect_array = suspect.to_s.split('')

      suspect_array.each_with_index do |value, index|
        if (value == secret_array[index])
          secret_array[index] = '0'
          suspect_array[index] = '+'
          plus += '+'
        end
      end

      suspect_array.each do |value|
        if (secret_array.include?(value))
          secret_array[secret_array.find_index(value)] = '-'
          minus += '-'
        end
      end
      result = plus + minus
      @guess[suspect.to_s] = result
      @round_number += 1
      @game_status = 'win' if result == '++++'
      @game_status = 'loose' if @round_number >= MAX_ROUNDS
      result
    end

    def hint
      if @hint_value.to_s.empty?
        @hint_value = ''
        hint_pos = Random.rand(SECRET_CODE_SIZE);
        hint_pos.times {@hint_value += '*'}
        @hint_value += @secret[hint_pos].to_s
        (SECRET_CODE_SIZE - hint_pos - 1).times {@hint_value += '*'}
      end
      @hint_value
    end

    def score
      hints_used = 0
      hints_used = 1 unless @hint_value.empty?
      MAX_SCORE - hints_used*HINT - @round_number*ROUND_PENALTY
    end

    def save_game(file)
      # File.open(file, 'w') { |f| f. }
    end
  end
end
