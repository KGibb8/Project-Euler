
class Pathway
  def initialize
    @day_count = 2 # 1st Jan 1901 starts on a Tuesday
    @days_of_week = Hash.new(0)
  end

  def count_day(day)
    @days_of_week[day] += 1
  end

  def generate_calendar
    @calendar = Calendar.new(UI.gets_year_range)
  end

  def day_counter
    @calendar.years.each do |year|
      year.months.each do |month|
        (1..month).each do |day|
          self.count_day(:sun_first) if (day == 1 && @day_count == 7)
          self.count_day(:monday) if @day_count == 1
          self.count_day(:tuesday) if @day_count == 2
          self.count_day(:wednesday) if @day_count == 3
          self.count_day(:thursday) if @day_count == 4
          self.count_day(:friday) if @day_count == 5
          self.count_day(:saturday) if @day_count == 6
          self.count_day(:sunday) if @day_count == 7
          @day_count >= 7 ? @day_count = 1 : @day_count += 1
        end
      end
    end
  end

  def execute
    UI.introduction
    self.generate_calendar
    start = Time.now
    UI.calculating
    self.day_counter
    finish = Time.now
    puts "Calculation took #{(finish - start)} seconds."
    puts "\nNumber of Sundays that fell on the first of the month during the twentieth century..."
    puts "Answer = #{@days_of_week[:sun_first]}"
  end
end
