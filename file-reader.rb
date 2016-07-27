
class FileReader
  attr_reader :string, :grid, :words
  def initialize(filename)
    @string = lines_to_s(filename)
    @grid = lines_to_arrays(filename)
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

  def lines_to_arrays(filename)
    open filename do |file|
      grid = []
      while line = file.gets
        grid << line.split.map {|i| i.to_i}
      end
      return grid
    end
  end

  def lines_to_s(filename)
    open (filename) do |file|
      string = ""
      while line = file.gets
        string << line
      end
      return string
    end
  end
end
