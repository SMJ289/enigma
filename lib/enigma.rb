require 'date'

class Enigma

  def generate_random_key
    numbers = []
    5.times { numbers << rand(9) }
    numbers
  end

  def generate_keys(key = generate_random_key)
    keys = {}
    values = key
    keys[:a] = values[0..1].join.to_i
    keys[:b] = values[1..2].join.to_i
    keys[:c] = values[2..3].join.to_i
    keys[:d] = values[3..4].join.to_i
    keys
  end

  def generate_date
    Date::today.strftime("%d%m%y")
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
    shifts[:a] = generate_keys[:a] + generate_offsets[:a]
    shifts[:b] = generate_keys[:b] + generate_offsets[:b]
    shifts[:c] = generate_keys[:c] + generate_offsets[:c]
    shifts[:d] = generate_keys[:d] + generate_offsets[:d]
    shifts
  end

  def char_set
    ("a".."z").to_a << " "
  end

  def shifted_char_set(shift)
    shifted_set = char_set.rotate(shift)
    char_set.zip(shifted_set).to_h
  end

  def shift_string(string)
    shifted_sets = {
      a: shifted_char_set(generate_shifts[:a]),
      b: shifted_char_set(generate_shifts[:b]),
      c: shifted_char_set(generate_shifts[:c]),
      d: shifted_char_set(generate_shifts[:d])
    }
    shift_chars(string, shifted_sets)
  end

  def unshift_string(string)
    unshifted_sets = {
    a: shifted_char_set(-generate_shifts[:a]),
    b: shifted_char_set(-generate_shifts[:b]),
    c: shifted_char_set(-generate_shifts[:c]),
    d: shifted_char_set(-generate_shifts[:d])
    }
    shift_chars(string, unshifted_sets)
  end

  def shift_chars(string, shifts)
    encrypted_message = []
    string.each_char.with_index do |char, index|
      if !char_set.include?(char)
        encrypted_message << char
      elsif index % 4 == 0
        encrypted_message << shifts[:a][char]
      elsif index % 4 == 1
        encrypted_message << shifts[:b][char]
      elsif index % 4 == 2
        encrypted_message << shifts[:c][char]
      else
        encrypted_message << shifts[:d][char]
      end
    end
    encrypted_message.join
  end

  def encrypt(string, key = generate_random_key, date = generate_date)
    encryption_data = {}
    encryption_data[:encryption] = shift_string(string)
    encryption_data[:key] = key
    encryption_data[:date] = date
    encryption_data
  end

  def decrypt(string, key, date = generate_date)
    decryption_data = {}
    decryption_data[:decryption] = unshift_string(string)
    decryption_data[:key] = key
    decryption_data[:date] = date
    decryption_data
  end

end
