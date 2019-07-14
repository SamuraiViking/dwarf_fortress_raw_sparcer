class DFRawParcerUtil
  # header format is [super_class:sub_class]
  def header?(line)
    line.match(/^\[\w+:\w+\]/)
  end

  def empty_line?(line)
    !line.match(/\S/)
  end

  def attribute?(line)
    line.match(/\[\w+:\w+\]/)
  end

  def attribute_include?(line, text)
    line.match(/\[\w+:#{text}\]/)
  end

  def starting_spaces_count(line)
    line = line.match(/^(\t+)/)
    return 0 if line.nil?

    starting_spaces = line[1]
    num_of_starting_spaces = starting_spaces.length
    num_of_starting_spaces
  end

  def num_of_indents(line)
    line = line.gsub('  ', "\t")
    line = line.count("\t")
  end

  # parses [first_value:second_value] to
  #
  # {
  #   first_value: 'super_class'
  #   second_value: 'sub_class'
  # }
  def parse_attribute(line)
    parsed_line = {
      key: '',
      value: ''
    }

    key = line.match(/\[(\w+)/)[1]
    value = line.match(/(\w+)\]/)[1]

    parsed_line[:key] = key
    parsed_line[:value] = value

    parsed_line
  end
end
