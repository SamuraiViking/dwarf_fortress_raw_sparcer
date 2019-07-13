require_relative 'DFRawParcerUtil'

# functions:
#   all_headers
#   header?
#   parse_header
#   display_header
class DFRawHeaderParcer < DFRawParcerUtil
  # reads all headers
  # inserts super classes in hash as keys
  # inserts sub classes into hash as value to associated super class key
  def all_headers_hash(file_name)
    file = File.open("raw/objects/#{file_name}.txt", 'r')
    all_objects_hash = {}

    file.each do |line|
      next unless header?(line)

      header = parse_line(line)
      super_class = header[:first_value]
      super_class = super_class.to_sym
      sub_class = header[:second_value]

      if all_objects_hash.key?(super_class)
        all_objects_hash[super_class] << sub_class
      else
        all_objects_hash[super_class] = [sub_class]
      end
    end
    all_objects_hash
  end

  # prints { super_object1: ['sub_object1','sub_object2], super_object2: ... } as
  #
  # super_object1
  #   sub_object1
  #   sub_object2
  #
  # super_object2
  #   sub_object1
  #   sub_object2
  def all_headers_str(file_name)
    all_headers_h = all_headers_hash(file_name)
    all_headers_s = ''
    all_headers_h.each do |super_class, sub_objects|
      all_headers_s += "#{super_class.to_s}\n"
      sub_objects.each do |sub_class|
        all_headers_s += "\t#{sub_class}\n"
      end
      all_headers_s += "\n"
    end
    all_headers_s
  end
end

DF_raw_header_parcer = DFRawHeaderParcer.new

puts DF_raw_header_parcer.all_headers_str('creature_tropical_new')
puts DF_raw_header_parcer.all_headers_hash('creature_tropical_new')
