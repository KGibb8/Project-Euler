
class Array
  def product
    inject(&Proc.new { |sum, x| sum * x })
  end
end
