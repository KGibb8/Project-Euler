
class FileReader
  attr_reader :string, :i_array, :words
  def initialize(filename)
    @string = lines_to_string(filename)
    @i_array = lines_to_arrays(filename)
    @words = gets_words(filename)
  end

  def gets_words(filename)
    open filename do |file|
      while line = file.gets
        line.gsub!(/"\,"/, " ")
        line.gsub!(/^\"|\"?$/, '')
        words = line.split
      end
      words
    end
  end

  def lines_to_i_arrays(filename)
    open filename do |file|
      lines = []
      while line = file.gets
        lines << line.split.map {|i| i.to_i}
      end
      return lines
    end
  end

  def lines_to_string(filename)
    open (filename) do |file|
      string = ""
      while line = file.gets
        string << line
      end
      return string
    end
  end
end
