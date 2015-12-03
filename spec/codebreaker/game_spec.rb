require 'spec_helper'
require 'codebreaker/game.rb'

module Codebreaker
  describe Game do
    let(:game) {Game.new}
      
    context "#start" do

      before do
        game.start
      end

      context 'when called first time' do
        before do
          @secret = game.instance_variable_get(:@secret)       
        end

        it "saves secret code" do
          expect(@secret).not_to be_empty
        end
        
        it "saves 4 numbers secret code" do
          expect(@secret.length).to eq(4)
        end
        
        it "saves secret code with numbers from 1 to 6" do
          expect(@secret).to match(/[1-6]+/)
        end
      end
    end

    context "#check" do
      context "wrong arguments" do

        context "when argument missing" do
          it "raise ArgumentError" do
            expect{game.check}.to raise_error(ArgumentError)
          end
        end

        context "arguments more than one" do
          it "raise ArgumentError" do
            expect{game.check(1,2)}.to raise_error(ArgumentError)
          end
        end

        context "argument length is more then 4" do
          it "raise ArgumentError" do
            expect{game.check(13456)}.to raise_error(ArgumentError)
          end
        end

        context "argument are not numbers from 1 to 6" do
          it "raise ArgumentError" do
            expect{game.check('c3po')}.to raise_error(ArgumentError)
          end
        end
      end

      context 'with good argument' do
        @test = [
          [3123, 5664, '', "return '' if all numbers wrong"],
          [3123, 5614, '-', "return '-' if one of the numbers is right, but stays on wrong position"],
          [3123, 5164, '+', "return '+' one of the number in right position"],
          [3123, 3131, '++-', "return '++-' when one of the number in different position and 2 numbers in right position"],
          [3123, 3123, '++++', "return '++++' user win the game"],
          [1234, 1551, '+'],
          [1234, 5634, '++'],
          [1234, 5234, '+++'],
          [1234, 3556, '-'],
          [1234, 3456, '--'],
          [1234, 3451, '---'],
          [1234, 3421, '----'],
          [1234, 1552, '+-'],
          [1234, 1542, '+--'],
          [1234, 1342, '+---'],
          [1234, 1532, '++-'],
          [1234, 1432, '++--'],
          [1234, 1233, '+++'],
          [1234, 1532, '++-'],
          [1234, 1432, '++--'],
          [1113, 3111, '++--'],
          [1113, 1111, '+++'],
          [1234, 2524, '+-']
        ]

        @test.each do |elem|
          text = elem[3] ? elem[3] : "when secret_number = #{elem[0]} and gues = #{elem[1]}  return '#{elem[2]}'"
          it text do
            game.instance_variable_set(:@secret, elem[0].to_s)
            expect(game.check(elem[1])).to eq(elem[2])
          end
        end
      end

      it "increment round number" do
        expect{game.check(1234)}.to change{game.round_number}.by(1)
      end
    end

    context "#hint" do

      it '#hint method was called' do
        expect(game).to respond_to(:hint)
      end

      it "change hint when called first time" do
        expect{game.hint}.to change{game.hint_value}
      end
      it "not change hint when called other time" do
        game.hint
        expect{game.hint}.not_to change{game.hint_value}
      end
      it "return one number of the secret code with * " do
        game.instance_variable_set(:@secret, '6543')
        expect(['6***','*5**','**4*','***3']).to include game.hint
      end
    end

    context "#score" do

      it '#score method was called' do
        expect(game).to respond_to(:score)
      end
      
      it "must be returned FixNum" do
        expect(game.score).to be_instance_of(Fixnum)
      end
      
      it "return write value" do
        round_number = 5
        game.instance_variable_set(:@round_number, round_number)
        game.instance_variable_set(:@hint_value, '**3*')
        val = Game::MAX_SCORE - Game::HINT_PENALTY - round_number*Game::ROUND_PENALTY
        expect(game.score).to eq(val)
      end
      
      it "changes with new round" do
        expect{game.check(1234)}.to change{game.score}
      end
    end

    context "#game_status win" do

      before do
        game.start
        game.instance_variable_set(:@secret, "1234")
        game.check("1234")
      end
      
      it '#win? method was called' do
        expect(game).to respond_to(:win?)
      end

      it "win?" do
        game.instance_variable_set(:@game_status, 'win')
        expect(game.win?).to eq(true)
      end
    end

    context "#game_status loose" do

      before do
        game.start
        game.instance_variable_set(:@round_number, 10)
        game.check("1234")
      end
      
      it '#lose? method was called' do
        expect(game).to respond_to(:lose?)
      end

      it "lose?" do
        game.instance_variable_set(:@game_status, 'loose')
        expect(game.lose?).to eq(true)
      end
    end

    context "#save game" do
      
      it '#save method was called' do
        expect(game).to respond_to(:save)
      end

      it 'generate user file' do
        game.instance_variable_set(:@game_status, "win")
        game.instance_variable_set(:@round_number, 6)
        game.save('r2d2')
        #expect(File.exist?("r2d2")).to eq true
      end
    end
  end
end
