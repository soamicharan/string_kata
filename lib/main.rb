def parse_to_number(numeric_string)
  numeric_string.include?(".") ? numeric_string.to_f : numeric_string.to_i
end

def is_number(numeric_string)
  # Check first character if its a number then return true
  # If it starts with . then look next character and if its number then its a decimal number, return true
  # If it starts with - then look for next character, if its number then its negetive integer
  # If it starts with -. then look for third character, if its number then its negetive decimal number.
  numeric_string.first =~ /[0-9]/) ||
  (numeric_string.first == '.' && numeric_string.second && numeric_string.second =~ /[0-9]/) ||
  (
    numeric_string.first == '-' && numeric_string.second &&
    (
      numeric_string.second =~ /[0-9]/ ||
      (numeric_string.second == '.' && numeric_string.third && numeric_string. =~ /[0-9]/)
    )
  )
end


def valid_delimiter_format(numbers)
  # Check numbers string input starts with number itself then no custom delimiter provided
  # If it does not start with number then valid delimiter format need to provide which includes as follows
  # First two characters should be //
  # Third should be delimiter character which length should be one character only
  # Fouth character should be new line character
  # Fifth character should be number.
  is_number(numbers) || (numbers[..2] == "//" && numbers[3] == '\n' && is_number(numbers[5..]))
end
  
  
  

def add(numbers)
  if numbers.empty?
    return 0
  end
  
  # Keep track of sum
  total = 0
    
  # Keep valid numeric character inside buffer until delimiter is detected
  number_buffer = ""
    
  # Delimiters
  default_delimiters = [',', '\n']
  
  if valid_delimiter_format(numbers)
    if numbers[..2] =="//"
      default_delimiters << numbers[2]
      
      # remove delimiter format
      numbers = numbers[5..]
    end
  else
    raise ArgumentError, "Invalid delimiter format."
  end
  
    
  0..numbers.size do |idx|
    # Take raw character
    number = "#{numbers[idx].inspect[1..-2]}"
    
    # If character is a digit OR it's the start of a number with '.' or '-' (when buffer is empty)
    if is_number(numbers[idx..])
      number_buffer += number
      
    # If delimiter detected then parse number buffer to number and add it to total
    # Reset the number buffer
    elsif delimiters.include?(number)
      total += parse_to_number(number_buffer)
      number_buffer = ""
      
    # Any other case is regarded as a non numeric digit occured in numeric string.
    else
      raise ArgumentError, "Input string contains non numeric character #{number}."
    end
  end
  
  if number_buffer.empty?
    raise ArgumentError,"Input string is invalid as ends with delimiter"
  end
  try
    total += parse_to_number(number_buffer)
  catch
    raise ArgumentError, "Invalid number #{number_buffer}"
  end
  # return the sum
  total
    
end