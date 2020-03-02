require 'date'

class Enigma

  def initialize
    @offsets = {}
    @keys = {}
  end

  def generate_random_key
    numbers = []
    5.times { numbers << rand(9) }
    numbers.join
  end

  def generate_keys(key = generate_random_key)
    @keys = {
      a: key[0..1].to_i,
      b: key[1..2].to_i,
      c: key[2..3].to_i,
      d: key[3..4].to_i
    }
  end

  def generate_date
    Date::today.strftime("%d%m%y")
  end

  def generate_offsets(date = generate_date)
    square_date = date.to_i ** 2
    truncated_date = square_date.to_s[-4..-1]

    @offsets = {
      a: truncated_date[0].to_i,
      b: truncated_date[1].to_i,
      c: truncated_date[2].to_i,
      d: truncated_date[3].to_i
    }
  end

  def generate_shifts
    shifts = {}
    shifts[:a] = @keys[:a] + @offsets[:a]
    shifts[:b] = @keys[:b] + @offsets[:b]
    shifts[:c] = @keys[:c] + @offsets[:c]
    shifts[:d] = @keys[:d] + @offsets[:d]
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

  def encrypt(string, key, date)
    generate_offsets(date)
    generate_keys(key)
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
