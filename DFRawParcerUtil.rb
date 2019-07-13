class DFRawParcerUtil

  # header format is [super_class:sub_class]
  def header?(line)
    line.match(/^\[\w+:\w+\]/)
  end

  def empty_line?(line)
    !line.match(/\S/)
  end

  # parses [first_value:second_value] to
  #
  # {
  #   first_value: 'super_class'
  #   second_value: 'sub_class'
  # }
  def parse_line(line)
    parsed_line = {
      first_value: '',
      second_value: ''
    }

    first_value = line.match(/\[(\w+)/)[1]
    second_value = line.match(/(\w+)\]/)[1]

    parsed_line[:first_value] = first_value
    parsed_line[:second_value] = second_value

    parsed_line
  end
end