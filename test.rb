require_relative 'DFRawParcerUtil'

class DFRawParser < DFRawParcerUtil
  attr_reader :json, :file_length, :file, :file_lines

  def initialize(file_name)
    @file = File.read(file_name)
    @file_lines = @file.split("\n")
    @file_length = @file_lines.length
    @json = init_json
  end

  def init_json(line_num = 0)
    parsed_line = parse_line(@file_lines[line_num])
    key = parsed_line[:key].to_sym
    value = parsed_line[:value].to_sym

    return { "#{key}": value.to_s } if line_num == @file_length - 1

    json = {}
    json[key] = { "#{value}": init_json(line_num + 1) }
    json
  end
end

test = DFRawParser.new('test.txt')

test.file_length
test.file
p test.json
