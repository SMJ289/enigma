require './test/test_helper'
require './lib/enigma'

class ShiftGeneratorTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_can_generate_final_shifts
    keys = @enigma.generate_keys("02715")
    offsets = @enigma.generate_offsets("040895")

    expected_shifts = {
      a: 3,
      b: 27,
      c: 73,
      d: 20
    }

    assert_equal expected_shifts, @enigma.generate_shifts(keys, offsets)
  end
end
