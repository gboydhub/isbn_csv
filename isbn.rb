def valid_isbn?(isbn)
  isbn_arr = isbn.split('')
  isbn_arr.reject! {|x| x=='-' || x==' '}
  isbn_sum = 0

  unless isbn_arr.length == 10 || isbn_arr.length == 13
    return false
  end
  isbn_checkdigit = isbn_arr.pop

  if isbn_checkdigit.downcase == 'x'
    isbn_checkdigit = 10
  else
    isbn_checkdigit = isbn_checkdigit.to_i
  end

  if isbn_arr.length == 9
    isbn_arr.each_with_index do |digit, pos|
      unless digit.to_i.to_s == digit
        return false
      end
      isbn_sum += digit.to_i * (pos+1)
    end
    if isbn_sum % 11 == isbn_checkdigit
      return true
    end

  elsif isbn_arr.length == 12
    isbn_arr.each_with_index do |digit, pos|
      unless digit.to_i.to_s == digit
        return false
      end
      if (pos+1).even?
        isbn_sum += digit.to_i * 3
      else
        isbn_sum += digit.to_i
      end
    end
    if (10 - (isbn_sum%10)) % 10 == isbn_checkdigit
      return true
    end
  end

  false
end