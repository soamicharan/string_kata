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
  
  # Check for negetive numbers
  negetive_checks = numbers.gsub(/(?<=^|\D)(?<num>-\d*\.?\d+)/).map{ Regexp.last_match[:num] }
  if !negetive_checks.empty?
    raise ArgumentError, "Negetives not allowed - #{negetive_checks.join(', ')}"
  end
  
  # Replace any delimiter to | character as placeholder
  # Split string by | character to get potential list of numbers
  numbers_format = numbers.gsub(/([#{default_delimiters.join('|')}])/, '|').split("|").map {
    |numeric_string| parse_to_number(numeric_string)
  }
    
  numbers_format.filter{ |num| num < 1000 }.sum
end