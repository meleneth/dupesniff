require 'find'

class Scriptviz
  def initialize
    @script_names = Hash.new
  end

  def import_dir(dir)
    Find.find(dir) do |path|
      next unless is_code_path? path
      add_script_file(path)
    end

    process_scripts
  end

  def is_code_path?(path)
    return true if path.match(/\.(vbs|rb|pl|pm|cmd)$/)
    return false
  end

  def add_script_file(path)
    @script_names[path] = File.basename(path)
  end

  def process_scripts
    matcher = Regexp.new "(#{@script_names.values.uniq.join("|")})"
    colormap = {'vbs' => 'lightblue', 'rb' => 'yellow', 'pl' => 'aquamarine', 'pm' => 'aquamarine', 'cmd' => 'lightgray', 'cs' => 'cyan3'}
    puts "digraph G {"
    puts "node [style=filled]"
    @script_names.keys.each do |path|
      File.foreach(path) do |line|
        match = matcher.match(line)
        
        puts "\"#{@script_names[path]}\" -> \"#{match[1]}\"" if match
      end

      path.match(/\.([^.]*)$/)
      color = colormap[$1]
      puts "\"#{@script_names[path]}\" [fillcolor = #{color}]"
    end
    puts "}"
  end
end
