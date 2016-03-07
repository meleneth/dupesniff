require 'parser'

class PythonParser < Parser
  attr_accessor :imports

  def initialize
    @imports = []
  end

  def parse_line(line)
    line.gsub! /#.*/, ''
    if /from (.*) import.*/.match(line)
      @imports << $1
      return
    end
    if /import (.*)/.match(line)
      @imports << $1
    end
  end

  def parse_import(line)
  end
end
