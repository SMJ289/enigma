module ShiftGenerator

  def generate_shifts(keys, offsets)
    { a: keys[:a] + offsets[:a],
      b: keys[:b] + offsets[:b],
      c: keys[:c] + offsets[:c],
      d: keys[:d] + offsets[:d] }
  end

end
