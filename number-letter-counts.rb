# If the numbers 1 to 5 are written out in words: one, two, three, four, five,
# then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

# If all the numbers from 1 to 1000 (one thousand) inclusive were written out
# in words, how many letters would be used?

# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and
# forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20
# letters. The use of "and" when writing out numbers is in compliance with
# British usage.


def numToWords(n)
  ## Only up to 1000
  ones = "one two three four five six seven eight nine".split()
  tens = "ten twenty thirty forty fifty sixty seventy eighty ninety".split()
  teens = "eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen".split()
  hundred = "hundred"
  thousand = "thousand"
  letters = 0
  if n == 0
    return "Zero"
  else
    split_n = n.to_s.scan(/./).map {|i| i.to_i}
    if n < 10
      return ones[n-1]
    elsif n < 20
      if n % 10 == 0
        return tens[split_n[0]-1]
      else
        return teens[split_n[1]-1]
      end
    elsif n < 100
      if n % 10 == 0
        return tens[split_n[0]-1]
      else
        return tens[split_n[0]-1] + ones[split_n[1]-1]
      end
    elsif n < 1000
      if n % 100 == 0
        return ones[split_n[0]-1] + hundred
      elsif split_n[1] == 0
          return ones[split_n[0]-1] + hundred + "and" + ones[split_n[2]-1]
      elsif split_n[1] == 1
        if n % 10 == 0
          return ones[split_n[0]-1] + hundred + "and" + tens[split_n[1]-1]
        else
          return ones[split_n[0]-1] + hundred + "and" + teens[split_n[2]-1]
        end
      else
        if n % 10 == 0
          return ones[split_n[0]-1] + hundred + "and" + tens[split_n[1]-1]
        else
          return ones[split_n[0]-1] + hundred + "and" + tens[split_n[1]-1] + ones[split_n[2]-1]
        end
      end
    elsif n < 1000000
      return ones[split_n[0]-1] + thousand
    end
  end
end

n = 1
while n <= 1000
  if n < 100
    puts numToWords(n)
  end
  letters += numToWords(n).length
  n += 1
end
