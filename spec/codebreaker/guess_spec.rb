require 'spec_helper'
 
module Codebreaker
  
  describe Guess do
    
    context "#valid?" do
      let(:valid) { Guess.new("1256") }
      let(:not_valid) { Guess.new("125634") }
      let(:not_valid_figures) { Guess.new("9173") }

      it "when data is valid" do
        expect(valid).to be_valid
      end

      it "if data is not valid" do
        expect(not_valid).to_not be_valid
      end

      it "if data is not valid" do
        expect(not_valid_figures).to_not be_valid
      end
    end 
  end
end
