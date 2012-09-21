class Person < ActiveRecord::Base
	set_table_name "people"

	def self.findidbyname(fullname)
		nameparts = fullname.split	
		lastnames = Person.find_all_by_lastname(nameparts[-1])
		if lastnames.length == 0
			return []
		else
			defmatch=[]
			for name in lastnames
				if name.firstname == nameparts[0] or name.nickname == nameparts[0]
					defmatch.push(name)
				end
			end
		end

		if defmatch.length > 0
			return defmatch
		else
			return lastnames
		end
	end
end
