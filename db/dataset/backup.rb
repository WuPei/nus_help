
  IO.read(moduleListName).split("\n").each do |line|
    if(line == nil) then
      next
    end

    m = line.split(",")
    if(m.length < 5) then
      puts "Ignoreing below, cuz info incomplete"
      p m
      next
    end

    moduleToCreate = NusModule.new
    moduleToCreate.code =  m[0].gsub("$",",")
    moduleToCreate.name =  m[1].gsub("$",",")
    moduleToCreate.description = ("Faculty: " + m[4]).gsub("$",",")
        # use faculty as description first
    moduleToCreate.save
    puts "Saved Module" + line
  end
