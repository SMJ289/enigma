require 'date'

module OffsetGenerator

  def generate_date
    Date::today.strftime("%d%m%y")
  end

  def square_date(date)
    date.to_i ** 2
  end

  def truncate_date(date)
    square_date(date).to_s[-4..-1]
  end

  def generate_offsets(date = generate_date)
    offset_values = truncate_date(date)

    { a: offset_values[0].to_i,
      b: offset_values[1].to_i,
      c: offset_values[2].to_i,
      d: offset_values[3].to_i }
  end

end
