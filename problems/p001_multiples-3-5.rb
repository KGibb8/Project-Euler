limit = 1000
sum = 0
n = 0
while n < limit
    if n % 5 == 0
        sum +=  n
        n +=  1
    elsif n % 3 == 0
        sum += n
        n += 1
    else
        n += 1
    end
    puts sum
end
