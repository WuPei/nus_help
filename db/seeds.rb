# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


def create_nus_module
  moduleListName = "db/dataset/moduleList.txt"

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
end


create_nus_module
