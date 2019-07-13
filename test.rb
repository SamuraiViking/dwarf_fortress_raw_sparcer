file = File.open("test.txt")

file_hash = {}
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

class Parser
  def initialize
    @index = 0
    @file = File.read("test.txt").split("\n")
    @file_length = @file.length
  end

  def parse_file(line)
    parsed_line = parse_line(@file[@index])
    key = parsed_line[:key]
    value = parsed_line[:value]

    return key if @index == @file_length - 1

    file_hash = {}
    file_hash[key] = { "#{value}": parse_file(@file[@index += 1]) }
    p file_hash
  end
end

puts Parser.new.parse_file("test.txt")
