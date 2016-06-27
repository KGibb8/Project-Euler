# If the numbers 1 to 5 are written out in words: one, two, three, four, five,
# then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

# If all the numbers from 1 to 1000 (one thousand) inclusive were written out
# in words, how many letters would be used?

# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and
# forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20
# letters. The use of "and" when writing out numbers is in compliance with
# British usage.

#############################################################
########################### LOOP ############################
#############################################################


n = 1
letters = 0
start = Time.now
while n <= 100000
  letters += numToWords(n).delete(' ').length
  n += 1
end
finish = Time.now
puts "Calculation too #{finish - start} seconds."
puts "There are #{numToWords(letters)} letters in numbers between one and #{n}"


#############################################################
####################### OPTIMISATION ########################
#############################################################

# UP TO 1,000,000

# Method fails if you input a 0 at the beginning of num
# e.g. num = 013024 (thirteen thousand and twenty four)
# actually returns "five thousand six hundred and fifty two"
# easy to create an exception to negate this 0

def numToWords(num)
  return "zero" if num == 0
  integers = num.to_s.scan(/./).map {|i| i.to_i}    # Splits number and maps to array
  integers = integers.reverse.each {|x| x}        # Reverse index for intuitive access / control flow

  def ones(a)
    return "" if a == 0
    ones = "one two three four five six seven eight nine".split()
    return ones[a-1]
  end

  def tens(a)
    return "" if a == 0
    tens = "ten twenty thirty forty fifty sixty seventy eighty ninety".split()
    return tens[a-1]
  end

  def teens(a)
    teens = "eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen".split()
    return teens[a-1]
  end

  def hundred(a, b, c)  # a is ones, b is tens, c is hundreds, ??d is words??
    return "" if c == 0
    hundred = "hundred"
    return ones(c) + " " + hundred if a + b == 0
    return ones(c) + " " + hundred + " and " + ones(a) if b == 0
    return ones(c) + " " + hundred + " and " + tens(b) if a == 0
    return ones(c) + " " + hundred + " and " + teens(a) if b == 1
    return ones(c) + " " + hundred + " and " + tens(b) + " " + ones(a)
  end

  def thousand(a, b, c, d, e=0, f=0) # a = ones, b = tens, c = hundreds, d = one thousands, e = ten thousands, f = hundred thousands
    thousand = "thousand"
    if f == 0 # if < 99,999
      if (c + e) == 0
        return ones(d) + " " + thousand if a + b == 0
        return ones(d) + " " + thousand + " and " + ones(a) if (b == 0)
        return ones(d) + " " + thousand + " and " + tens(b) if (a == 0)
        return ones(d) + " " + thousand + " and " + teens(a) if (b == 1)
        return ones(d) + " " + thousand + " and " + tens(b) + " " + ones(a)
      else
        return ones(d) + " " + thousand + " " + hundred(a, b, c)
      end

      if (c + d) == 0
        return tens(e) + " " + thousand if a + b == 0
        return tens(e) + " " + thousand + " and " + ones(a) if (b == 0)
        return tens(e) + " " + thousand + " and " + tens(b) if (a == 0)
        return tens(e) + " " + thousand + " and " + teens(a) if (b == 1)
        return tens(e) + " " + thousand + " and " + tens(b) + " " + ones(a)
      else
        return tens(e) + " " + thousand + " " + hundred(a, b, c)
      end

      if c == 0
        if e == 1
          return teens(d) + " " + thousand if a + b == 0
          return teens(d) + " " + thousand + " and " + ones(a) if (b == 0)
          return teens(d) + " " + thousand + " and " + tens(b) if (a == 0)
          return teens(d) + " " + thousand + " and " + teens(a) if (b == 1)
        else
          return teens(d) + " " + thousand + " and " + tens(b) + " " + ones(a)
        end

      elsif e == 1
        return teens(d) + " " + thousand + " " + hundred(a, b, c)

      else
        return tens(e) + " " + ones(d) + " " + thousand if a + b == 0
        return tens(e) + " " + ones(d) + " " + thousand + " and " + ones(a) if (b == 0)
        return tens(e) + " " + ones(d) + " " + thousand + " and " + tens(b) if (a == 0)
        return tens(e) + " " + ones(d) + " " + thousand + " and " + teens(a) if (b == 1)
        return tens(e) + " " + ones(d) + " " + thousand + " and " + tens(b) + " " + ones(a)
      end

    return tens(e) + " " + ones(d) + " " + thousand + " " + hundred(a, b, c)
    else
      if c == 0
        return hundred(d, e, f) + " " + thousand if (a + b + d + e) == 0
        return hundred(d, e, f) + " " + thousand + " and " + ones(a) if b == 0
        return hundred(d, e, f) + " " + thousand + " and " + tens(b) if a == 0
        return hundred(d, e, f) + " " + thousand + " and " + teens(a) if (b == 1)
        return hundred(d, e, f) + " " + thousand + " and " + tens(b) + " " + ones(a)
      else
        return hundred(d, e, f) + " " + thousand + " " + hundred(a, b, c)
      end
    end

  end

  return ones(integers[0]) if Math::log10(num) < 1  # < 10

  if Math::log10(num/2) < 1  # < 20
    return tens(integers[1]) if num % 10 == 0
    return teens(integers[0])
  end

  if Math::log10(num) < 2  # < 100
    return tens(integers[1]) if integers[0] == 0
    return tens(integers[1]) + " " + ones(integers[0])
  end

  if Math::log10(num) < 3 #  < 1000
    return hundred(integers[0], integers[1], integers[2])
  end

  if Math::log10(num) < 6  # < 1000000
    return thousand(integers[0], integers[1], integers[2],integers[3]) if integers[4].nil? # integers.length == 4 ## or if
    return thousand(integers[0], integers[1], integers[2],integers[3], integers[4]) if integers[5].nil?
    return thousand(integers[0], integers[1], integers[2], integers[3], integers[4], integers[5])
  end

  if Math::log(num) < 12 # < 1000,000,000,000
    million = "million"
    return hundred(integers[6], integers[7], integers[8]) + million + thousand(integers[0], integers[1], integers[2], integers[3], integers[4], integers[5])
  end
end



#############################################################
###################### SECOND ATTEMPT #######################
#############################################################

def numToWords(n)

  def divisible(divisor, dividend)
    divisor % dividend == 0
  end

  def ones(n)
    ones = "one two three four five six seven eight nine".split()
    return ones[n-1]
  end

  def tens(n)
    tens = "ten twenty thirty forty fifty sixty seventy eighty ninety".split()
    return tens[n-1]
  end

  def teens(n)
    teens = "eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen".split()
    return teens[n-1]
  end

  hundred = "hundred"
  thousand = "thousand"
  return "zero" if n == 0
  integers = n.to_s.scan(/./).map {|i| i.to_i}

  return ones(n) if Math::log10(n) < 1  # < 10

  if Math::log10(n/2) < 1  # < 20
    return tens(integers[0]) if divisible(n,10)
    return teens(integers[1])
  end

  if Math::log10(n) < 2  # < 100
    return tens(integers[0]) if divisible(n,10)
    return tens(integers[0]) + " " + ones(integers[1])
  end

  if Math::log10(n) < 3 #  < 1000
    return ones(integers[0]) + " " + hundred if divisible(n,100)
    return ones(integers[0]) + " " + hundred + " and " + ones(integers[2]) if integers[1] == 0
    if integers[1] == 1
      return ones(integers[0]) + " " + hundred + " and " + tens(integers[1]) if divisible(n,10)
      return ones(integers[0]) + " " + hundred + " and " + teens(integers[2])
    end
    return ones(integers[0]) + " " + hundred + " and " + tens(integers[1]) if divisible(n,10)
    return ones(integers[0]) + " " + hundred + " and " + tens(integers[1]) + " " + ones(integers[2])
  end
end


#############################################################
####################### FIRST ATTEMPT #######################
#############################################################

# UP TO 1,000

def numToWords(n)
  ones = "one two three four five six seven eight nine".split()
  tens = "ten twenty thirty forty fifty sixty seventy eighty ninety".split()
  teens = "eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen".split()
  hundred = "hundred"
  thousand = "thousand"
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
