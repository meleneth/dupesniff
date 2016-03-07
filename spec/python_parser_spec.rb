require 'spec_helper'
require 'python_parser'

describe "PythonParser" do
  before(:each) do
    @parser = PythonParser.new
  end
  describe "#parse_line" do
    it "parses lines" do
      @parser.parse_line("import libram")
      expect(@parser.imports[0]).to eq("libram")
    end
    it "doesn't parse comment lines" do
      @parser.parse_line("#import libram")
      expect(@parser.imports).to eq([])
    end
    it "parses from imports" do
      @parser.parse_line("from foo import bar")
      expect(@parser.imports).to eq(["foo"])
    end
  end
end
