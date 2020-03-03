module KeyGenerator

  def generate_random_key
    numbers = []
    5.times { numbers << rand(9) }
    numbers.join
  end

  def generate_keys(key = generate_random_key)
    { a: key[0..1].to_i,
      b: key[1..2].to_i,
      c: key[2..3].to_i,
      d: key[3..4].to_i }
  end
  
end
