
class FileReader
  attr_reader :string, :i_array, :words, :lines, :poker
  def initialize(filename)
    @string = lines_to_string(filename)
    @i_array = lines_to_i_arrays(filename)
    @words = gets_words(filename)
    @lines = gets_lines(filename)
    @poker = poker_hands(filename)
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

  def gets_lines(filename)
    open filename do |file|
      lines = []
      while line = file.gets
        line.gsub!(/"\,"/, " ")
        line.gsub!(/^\"|\"?$/, '')
        lines << line.strip
      end
      return lines
    end
  end

  def poker_hands_hash(filename)
    open filename do |file|
      lines = {}
      count = 1
      while line = file.gets
        lines[count] = line.split.each_slice(5).to_a
        count += 1
      end
      lines
    end
  end

  def poker_hands(filename)
    open filename do |file|
      lines = []
      count = 1
      while line = file.gets
        lines << line.split.each_slice(5).to_a
      end
      lines
    end
  end



  def lines_to_i_arrays(filename)
    open filename do |file|
      lines = []
      while line = file.gets
        line.gsub!(","," ")
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
