require 'date'

class Enigma

  def generate_random_key
    numbers = []
    5.times { numbers << rand(9) }
    numbers
  end

  def make_keys
    keys = {}
    values = generate_random_key
    keys[:a] = values[0..1].join.to_i
    keys[:b] = values[1..2].join.to_i
    keys[:c] = values[2..3].join.to_i
    keys[:d] = values[3..4].join.to_i
    keys
  end

  def generate_date(date = Date::today.strftime("%e%m%y"))
    date
  end

  def square_date
    generate_date.to_i ** 2
  end

  def truncate_date
    square_date.to_s[-4..-1]
  end

  def generate_offsets
    offsets = {}
    values = truncate_date
    offsets[:a] = values[0].to_i
    offsets[:b] = values[1].to_i
    offsets[:c] = values[2].to_i
    offsets[:d] = values[3].to_i
    offsets
  end

  def generate_shifts
    shifts = {}
    shifts[:a] = make_keys[:a] + generate_offsets[:a]
    shifts[:b] = make_keys[:b] + generate_offsets[:b]
    shifts[:c] = make_keys[:c] + generate_offsets[:c]
    shifts[:d] = make_keys[:d] + generate_offsets[:d]
    shifts
  end








  def encrypt(string, key, date)
    encryption = {}
  end

  # def encrypt(string, key, date)
    # encryption_hash = {}
    # encryption_hash[:encryption] = method_that_encrypts_string
    # encryption_hash[:key] = method_that_makes_key
    # encryption_hash[:date] = method_that_gets_date
  # end
end
