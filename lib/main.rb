def parse_to_number(numeric_string)
  if numeric_string.empty?
    return 0
  end

  begin
    numeric_string.include?(".") ? Float(numeric_string) : Integer(numeric_string)
  rescue
    raise ArgumentError, "Input string has invalid number #{numeric_string}."
  end
end

def is_number(numeric_string)
  # Check first character if its a number then return true
  # If it starts with . then look next character and if its number then its a decimal number, return true
  # If it starts with - then look for next character, if its number then its negetive integer
  # If it starts with -. then look for third character, if its number then its negetive decimal number.
  numeric_string[0] =~ /[0-9]/ ||
  (numeric_string[0] == '.' && numeric_string[1] && numeric_string[1] =~ /[0-9]/) ||
  (
    numeric_string[0] == '-' && numeric_string[1] &&
    (
      numeric_string[1] =~ /[0-9]/ ||
      (numeric_string[1] == '.' && numeric_string[2] && numeric_string[2] =~ /[0-9]/)
    )
  )
end
  
  
  

def add(numbers)
  if numbers.empty?
    return 0
  end
  
    
  # Delimiters
  default_delimiters = [',', '\n']

  # If delimiter format is provided
  if numbers.start_with?("//")
    delimiter_match = numbers.match(/(?<delimiter_format>\/\/(?<delimiter>\D+)\n)?/m)
    if delimiter_match[:delimiter_format] && delimiter_match[:delimiter]
      default_delimiters << delimiter_match[:delimiter]
      
      # remove delimiter format
      numbers = numbers[delimiter_match.end(0)..]
    else
      raise ArgumentError, "Invalid delimiter format."
    end
  end
  
  # Replace any delimiter to | character as placeholder
  # Split string by | character to get potential list of numbers
  numbers_format = numbers.gsub(/([#{default_delimiters.join('|')}])/, '|').split("|").map {
    |numeric_string| parse_to_number(numeric_string)
  }
    
  # 0..numbers.size do |idx|
  #   # Take raw character
  #   number = "#{numbers[idx].inspect[1..-2]}"
    
  #   # If character is a digit OR it's the start of a number with '.' or '-' (when buffer is empty)
  #   if is_number(numbers[idx..])
  #     number_buffer += number
      
  #   # If delimiter detected then parse number buffer to number and add it to total
  #   # Reset the number buffer
  #   elsif delimiters.include?(number)
  #     total += parse_to_number(number_buffer)
  #     number_buffer = ""
      
  #   # Any other case is regarded as a non numeric digit occured in numeric string.
  #   else
  #     raise ArgumentError, "Input string contains non numeric character #{number}."
  #   end
  # end
  
  # if number_buffer.empty?
  #   raise ArgumentError,"Input string is invalid as ends with delimiter"
  # end
  numbers_format.sum
    
end