class Vote < ActiveRecord::Base
	set_table_name "votes"

	def findbilltitle
		if self.billnumber == 0
			return ''
		else
			bill = Bill.find_by_session_and_billtype_and_number(self.billsession, self.billtype, self.billnumber)
			return bill.fulltitle
		end
	end

end
