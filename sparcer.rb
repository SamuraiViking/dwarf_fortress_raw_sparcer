# mission read b_detail_plan_default.txt

file = File.open('raw/objects/b_detail_plan_default.txt', 'r')

# functions:
#   all_headers
#   header?
#   parse_header
#   display_header
class DFRawSparcer
  # reads all headers
  # inserts super classes in hash as keys
  # inserts sub classes into hash as value to associated super class key
  def all_headers(file)
    all_objects_hash = {}

    file.each do |line|
      next unless header?(line)

      header = parse_header(line)
      sub_class = header[:sub_class]
      super_class = header[:super_class]
      super_class = super_class.to_sym

      if all_objects_hash.key?(super_class)
        all_objects_hash[super_class] << sub_class
      else
        all_objects_hash[super_class] = [sub_class]
      end
    end
    all_objects_hash
  end

  # header format is [super_class:sub_class]
  def header?(line)
    line.match(/^\[\w+:\w+\]/)
  end

  # parses [super_class:sub_class] to
  #
  # {
  #   super_class: 'super_class'
  #   sub_class: 'sub_class'
  # }
  def parse_header(line)
    header = {
      super_class: '',
      sub_class: ''
    }

    super_class = line.match(/\[(\w+)/)[1]
    sub_class = line.match(/(\w+)\]/)[1]

    header[:super_class] = super_class
    header[:sub_class] = sub_class

    header
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

  def display_all_objects(all_objects)
    all_objects.each do |super_class, sub_objects|
      puts super_class
      sub_objects.each do |sub_class|
        puts "\t#{sub_class}"
      end
      puts
    end
  end
end

df_parse = DFRawSparcer.new

all_objects = df_parse.all_headers(file)

df_parse.display_all_objects(all_objects)
