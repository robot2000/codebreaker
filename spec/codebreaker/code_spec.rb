require 'spec_helper'
 
module Codebreaker
  describe Code do

    context "#generate_secret" do
      
      let(:code) { Code.new }

      before do
        code.generate_secret
      end
      
      it "saves secret code" do
        expect(code.instance_variable_get(:@secret_code)).not_to be_empty
      end

      it "saves 4 numbers secret code" do
        expect(code.instance_variable_get(:@secret_code)).to have(4).items
      end

      it "saves secret code with numbers from 1 to 6" do
        expect(code.instance_variable_get(:@secret_code)).to match(/[1-6]+/)
      end
    end
  end
end
