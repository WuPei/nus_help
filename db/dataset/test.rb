puts "start"

moduleListName = "moduleList.txt"

IO.read(moduleListName).split("\n").each do |line|
  m = line.split(":")
  code = m[0];
  name = m[1];
  mc = m[2];
  faculty = m[4];
end
