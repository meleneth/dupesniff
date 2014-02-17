require 'spec_helper'
require 'dupesniff'

describe "Dupesniff" do
  describe "#new" do
    it "Doesnt take arguments" do
      sniffer = Dupesniff.new
    end
  end
end
