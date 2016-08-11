
array_scan = Proc.new {|item| item.scan(/./)}
count_items = Proc.new {|x| x.count}
sum = Proc.new {|sum, item| sum += item}
score = Proc.new {|item| item.upcase.ord - 64}
array_to_i = Proc.new {|i| i.to_i}
