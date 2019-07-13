require_relative 'DFRawParcerUtil'

class DFRawObjectParcer < DFRawParcerUtil
  def object_hash(file_name, object_name)
    object_h = {}
    print_out = false
    file = File.open("raw/objects/#{file_name}.txt", 'r')
    file.each do |line|
      if line.include?(object_name)
        print_out = true
      end

      puts line if print_out

      if empty_line?(line) && print_out
        break
      end
    end
  end
end

DF_raw_object_Parcer = DFRawObjectParcer.new

DF_raw_object_Parcer.object_hash('creature_subterranean', 'ELEMENTMAN_MAGMA')
