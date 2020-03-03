require './test/test_helper'
require './lib/enigma'

class KeyGeneratorTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_can_generate_random_key
    assert_equal 5, @enigma.generate_random_key.length
  end

  def test_it_can_generate_keys_hash
    expected = {
      a: 2,
      b: 27,
      c: 71,
      d: 15
    }
    assert_equal expected, @enigma.generate_keys("02715")
  end

end
