require './test/test_helper'
require './lib/enigma'

class OffsetGeneratorTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_can_generate_todays_date
    date = Date::today.strftime("%d%m%y")

    assert_equal date, @enigma.generate_date
  end

  def test_it_can_square_date
    assert_equal 1672401025, @enigma.square_date("040895")
  end

  def test_it_can_truncate_date
    assert_equal "1025", @enigma.truncate_date("040895")
  end

  def test_it_can_generate_offsets
    expected = {
      a: 1,
      b: 0,
      c: 2,
      d: 5
    }
    assert_equal expected, @enigma.generate_offsets("040895")
  end

end
