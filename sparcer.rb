# mission read b_detail_plan_default.txt

file = File.open('raw/objects/b_detail_plan_default.txt','r')

file.each do |line|
  puts line
end
