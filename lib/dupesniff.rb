require 'parser/simple'

class Dupesniff;
attr_accessor :current_filename;


def initialize
  @parser = SimpleParser.new
end

end;
