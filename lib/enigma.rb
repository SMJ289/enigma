require 'date'

class Enigma

  def generate_random_key
    numbers = []
    5.times { numbers << rand(9) }
    numbers
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
