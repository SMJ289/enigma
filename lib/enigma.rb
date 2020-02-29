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
    keys[:a] = values[0..1]
    keys[:b] = values[1..2]
    keys[:c] = values[2..3]
    keys[:d] = values[3..4]
    keys
  end



  def encrypt(string, key, date)
    encryption = {}
  end

  def generate_date(date = Date::today.strftime("%e%m%y"))
    date
  end



  # def encrypt(string, key, date)
    # encryption_hash = {}
    # encryption_hash[:encryption] = method_that_encrypts_string
    # encryption_hash[:key] = method_that_makes_key
    # encryption_hash[:date] = method_that_gets_date
  # end
end
