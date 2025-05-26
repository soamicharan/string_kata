 parse_to_number(numeric_string)
  numeric_string.include?(".") ? numeric_string.to_f : numeric_string.to_i
end

def add(numbers)
  if numbers.empty?
    raise ArgumentError, "Input string contains empty values."
  end
  
  # Keep track of sum
  total = 0
    
  # Keep valid numeric character inside buffer until delimiter is detected
  number_buffer = ""
    
  # Delimiter
  delimiter = ','
    
  numbers.each_char do |number|
    # If character is a digit OR it's the start of a number with '.' or '-' (when buffer is empty)
    if number =~ /[0-9]/ ||
       (number_buffer.empty? && ['.', '-'].include?(number)) ||
       (number == '.' && !number_buffer.include?('.'))
      number_buffer += number
      
    # If delimiter detected then parse number buffer to number and add it to total
    # Reset the number buffer
    elsif number == delimiter
      # Special case when number buffer either empty or only contain negetive sign or decimal then consider as empty.
      if number_buffer.empty? || ['.', '-'].include?(number_buffer)
        raise ArgumentError, "Input string contains empty values."
      end
      total += parse_to_number(number_buffer)
      number_buffer = ""
      
    # Any other case is regarded as a non numeric digit occured in numeric string.
    else
      raise ArgumentError, "Input string contains non numeric character #{number}."
    end
  end
    
  # Final case when loop terminates with remainder number buffer need to process
  if ['.', '-'].include?(number_buffer)
    raise ArgumentError, "Input string contains empty values."
  end
  total += parse_to_number(number_buffer)
    
  # return the sum
  total
    
end