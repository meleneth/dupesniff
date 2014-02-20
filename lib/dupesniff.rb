require 'parser/simple'
require 'find'

class Dupesniff
  attr_accessor :current_filename

  def initialize
    @parser = SimpleParser.new
    @current_path = nil
    @lines = Hash.new(0)
  end

  def import_dir(dir)
    Find.find(dir) do |path|
      next unless is_code_path? path
      import_file(path)
    end
  end

  def switch_file(path)
    @current_path = path
  end

  def import_file(path)
    switch_file(path)
    File.foreach(path) do |line|
      import_line(line)
    end
  end

  def import_line(line)
    line.encode!('utf-16', 'utf-8', :invalid => :replace, :replace => '')
    line.encode!('utf-8', 'utf-16')
    line.gsub!(/^\s+/, '')
    line.gsub!(/\s+$/, '')
    @lines[line] = @lines[line] + 1
  end

  def is_code_path?(path)
    return true if path.match(/\.(vbs|rb|pl|pm|cmd)$/)
    return false
  end

  def dump
    lines_in_order = @lines.keys.sort{|a, b| @lines[b] <=> @lines[a]}
    lines_in_order.each do |line|
      puts "#{@lines[line]} #{line}"
    end
  end

end
