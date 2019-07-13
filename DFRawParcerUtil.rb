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
    line.match(/^(\s+)/)[1].length
  end

  # parses [first_value:second_value] to
  #
  # {
  #   first_value: 'super_class'
  #   second_value: 'sub_class'
  # }
  def parse_line(line)
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