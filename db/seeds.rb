# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


def create_nus_module
  moduleListName = "db/dataset/module.txt"
  moduleListJson = "db/dataset/moduleInfo.json"


  JSON.parse(IO.read(moduleListJson)).each do |k,m|
    next unless m['code']
    moduleToCreate = NusModule.new
    moduleToCreate.code =  m["code"]
    moduleToCreate.name =  m["title"]
    moduleToCreate.description = m["desc"]
          # use faculty as description first
    moduleToCreate.save
    puts "Saved Module" + m["code"]
  end

end


create_nus_module
