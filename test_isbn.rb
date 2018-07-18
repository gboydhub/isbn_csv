require 'minitest/autorun'
require_relative 'isbn.rb'

class TestISBN < Minitest::Test
  def test_assert_1_equals_1
    assert_equal(1, 1)
  end
  def test_invalid_isbn_is_false
    assert_equal(false, valid_isbn?('abcd'))
  end
  def test_valid_isbn_10_is_true
    assert_equal(true, valid_isbn?('0471958697'))
  end
  def test_valid_isbn10_with_x
    assert_equal(true, valid_isbn?('877195869x'))
  end
  def test_valid_isbn10_with_dashes
    assert_equal(true, valid_isbn?('0-321-14653-0'))
  end
  def test_valid_isbn10_with_space
    assert_equal(true, valid_isbn?('0 321 14653 0'))
  end
  def test_valid_isbn13
    assert_equal(true, valid_isbn?('9780470059029'))
  end
  def test_valid_isbn13_with_dashes
    assert_equal(true, valid_isbn?('978-0-13-149505-0'))
  end
  def test_valid_isbn13_with_spaces
    assert_equal(true, valid_isbn?('978 0 471 48648 0'))
  end

  def test_batch_invalid_isbns
    isbn_batch = ["4780470059029", "0-321@14653-0", "877195x869", "", " ", "-"]
    isbn_batch.each do |isbn|
      assert_equal(false, valid_isbn?(isbn))
    end
  end
end