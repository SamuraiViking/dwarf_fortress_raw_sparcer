require_relative 'DFRawParcerUtil'

class DFRawObjectParcer < DFRawParcerUtil
  def initialize
    @file_hash = {}
    @prev_super_class_key = ''
    @parse_state = ''
  end
  def object_hash(file_name, object_name)
    file = File.open("raw/objects/#{file_name}.txt", 'r')
    file.each do |line|
      line = line.gsub(/\s/, '')
      case @parse_state
      when 'searching_for_header' then searching_for_header(line)
      if header?(line)
        grab_header_data(line)
      end
    end
    @file_hash
  end


  def searching_for_header(line)
    line = line.gsub(/\s/, '')
    
  end

  def grab_header_data(line)
    parsed_line = parse_line(line)
    key = parsed_line[:key]
    value = parsed_line[:value]
    @file_hash[key] = { "#{value}": '' }
  end
end

DF_raw_object_Parcer = DFRawObjectParcer.new

puts DF_raw_object_Parcer.object_hash('creature_mountain_new', 'WOLVERINE_MAN')

{
  'CREATURE': {
    'WOLVERINE_MAN': {
      'Attribute1': 1,
      'Attribute2': 2,
      'Attribute3': 3
    }
  }
}
