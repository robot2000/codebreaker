require 'spec_helper'
require 'codebreaker/guess.rb'
require 'codebreaker/player.rb'
require 'codebreaker/game.rb'


module Codebreaker
  describe Game do
    
    let(:player) {Player.new("test")}
    let(:game) {Game.new(player)}
    
    context "#generate_secret" do

      it "save the secret code" do
        expect(game.secret).not_to be_empty
      end

      it "have 4 numbers" do
        expect(game.secret.size).to eq(4)
      end

      it "secret is valid" do
        expect(game.secret).to match(/^[1-6]{4}$/)
      end
    end

    context "#guess" do

      before(:each) do
        game.instance_variable_set(:@secret, "1234")
      end

      it "return right string for guesses" do
        suspect = Guess.new "1256"
        expect(game.guess(suspect)).to eq"++"
      end

      it "return right string for guesses" do
        suspect = Guess.new "1356"
        expect(game.guess(suspect)).to eq"+-"
      end

      it "return right string for guesses" do
        suspect = Guess.new "5555"
        expect(game.guess(suspect)).to eq""
      end

      it "return right string for guesses" do
        suspect = Guess.new "1234"
        expect(game.guess(suspect)).to eq"++++"
      end

      it "return right string for guesses" do
        suspect = Guess.new "1111"
        expect(game.guess(suspect)).to eq"+---"
      end

      it "return right string for guesses" do
        suspect = Guess.new "4321"
        expect(game.guess(suspect)).to eq"----"
      end
      it "return right string for guesses" do
        suspect = Guess.new "6543"
        expect(game.guess(suspect)).to eq"--"
      end

      it "return right string for guesses" do
        suspect = Guess.new "1243"
        expect(game.guess(suspect)).to eq"++--"
      end
    end
  end
end
