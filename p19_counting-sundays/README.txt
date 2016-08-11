
  MANIPULATING TIME CLASS

  def start_day
    day_count = 0
    today = Time.now
    year = today.year.to_s.to_i
    until year == year_to_count_to
      if year > year_to_count_to
        year == today.year ? month = today.month.to_s.to_i : month = 12
        until month == 0
          year == today.year ? day = today.month.to_s.to_i : *THIS CHANGES => WONT WORK*
            until day == 0
            day -= 1
            day_count += 1
          end
          month -= 1
        end
        year -= 1
      end
    end
  end

  # should determine which day of week the calendar will start on.
  # requires a fixed point in time -> relating to this enables a count of days + or -

  # count backwards from Time.now to the point at which the calendar ends => calendar.years[-1].year
  # determine the day_of_week relative to your count by (count % 7) returns number and Time.now.day

  # 365 % 7 == 1
  # 366 % 7 == 2
  # Therefore if a year is !leap, starting day_of_week of following year moves forward by 1
  # 1st Jan 1900 is a Monday, 1st Jan 1901 is a Tuesday, 1st Jan 1902 is a Wednesday,
  # 1st Jan 1903 is a Thursday, 1st Jan 1904 is a Friday, 1st Jan 1905 is a Sunday, ...
  # if year is leap, starting day_of_week of YEAR AFTER moves forward by 2
  # modulos == sum of modulos
  # modulos % 7 == relative day to starting day

  # Best method is to use my Year class to generate the relevant years and use the modulo
  # idea as above on the year.days? method (returns 365/366 if leap?)


  IDEAS FOR HOW TO DEAL WITH CLASS ORGANISATION + DEPENDENCIES

  We could:

   a) UI takes two dates and pumps them into the program separately rather than as a range
      Generate a calendar from start_year until present (Time.now.year)
      Using our year class, count backwards from calendar.years[-1] to end_year (as output by UI)
      + use this to determine relative starting day_of_week
      Then only do the day_counter operation on the years (calendar.years[0]..calendar.years[*end_year*])
      THIS IS ALL A BIT CONVOLUTED AND HAS MANY DEPENDENCIES.

   b) Redesign the code. Needs to be done anyway. New class is created to separate out day_count
      and days_of_week from Pathway. Pathway becomes a simple executable file with the control flow
      of the program.
