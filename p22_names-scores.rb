# Using names.txt (right click and 'Save Link/Target As...'), a 46K text file
# containing over five-thousand first names, begin by sorting it into
# alphabetical order. Then working out the alphabetical value for each name,
# multiply this value by its alphabetical position in the list to obtain a name score.

# For example, when the list is sorted into alphabetical order, COLIN, which is
# worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would
# obtain a score of 938 × 53 = 49714.

# What is the total of all the name scores in the file?

class String
  def is_upper?
    self == self.upcase
  end

  def is_lower?
    self == self.downcase
  end
end

def gets_names(filename)
  open filename do |file|
    score = 0
    while line = file.gets
      line.gsub!(/"\,"/, " ")
      line.gsub!(/^\"|\"?$/, '')
      names = line.split
      names.sort!
      index = 1
      names.each do |name|
        name_score = []
        letters = name.scan(/./)
        for i in letters
          if i.is_upper?
            i = (i.ord - 64)
            name_score.push(i)
          elsif i.is_lower?
            i = (i.ord - 96)
            name_score.push(i)
          # else --> take into account other characters and nulify
          end
        end
        sum = 0
        name_score.each do |x|
          sum += x
        end
        score += (sum * index)
        index += 1
      end
    end
  return score
  end
end

start = Time.now
answer = gets_names('p022_names.txt')
puts answer

finish = Time.now
puts "Calculation took #{finish - start} seconds."
