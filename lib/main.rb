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

  # Custom delimiter regex pattern
  custom_delimiter_pattern = %r{\A//(\[[^\[\]]+\])+\n}

  # If delimiter format is provided
  if numbers.start_with?("//")
    if !custom_delimiter_pattern.match?(numbers)
      raise ArgumentError, "Invalid delimiter format."
    end

    delimiter_match = numbers.match(/(?<delimiter_format>\/\/(?<delimiter>\D+)\n)?/m)
    if delimiter_match[:delimiter_format] && delimiter_match[:delimiter]
      # Extract delimiter string from inside brackets
      bracket_delimiters = delimiter_match[:delimiter].scan(/\[(?<delimiter>[^\[\]]+)\]/).flatten
      default_delimiters += bracket_delimiters
      
      # remove delimiter format
      numbers = numbers[delimiter_match.end(0)..]
    else
      raise ArgumentError, "Invalid delimiter format."
    end
  end
  
  # Escape special character *, [, ], ^, - for regex.
  default_delimiters = default_delimiters.map{ |delim| delim.gsub(/([\-\^\]\[\*])/, '\\\\\1')  }
  
  # Replace any delimiter to | character as placeholder
  # Split string by | character to get potential list of numbers
  numbers_format = numbers.gsub(/#{default_delimiters.uniq.join('|')}/, '|').split("|").map {
    |numeric_string| parse_to_number(numeric_string)
  }

  negetive_numbers = numbers_format.filter{ |num| num < 0 }
  if negetive_numbers.any?
    raise ArgumentError, "Negetives not allowed - #{negetive_numbers.map(&:to_s).join(', ')}"
  end
    
  numbers_format.filter{ |num| num < 1000 }.sum
end