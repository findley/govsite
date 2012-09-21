class State < ActiveRecord::Base
	set_table_name "people_roles"

	def self.searchstate(state)
		state = ActiveRecord::Base.connection.quote('%' + state + '%')
		sql = <<END_QUERY
	SELECT personid FROM people_roles p where state like #{state} and enddate > '2012-02-01';
END_QUERY
		ans=[]
		for pid in self.find_by_sql(sql) do
			id = pid.personid.to_i
			sql2 = <<END_QUERY
	select * from people_votes pv
	left join votes v on pv.voteid = v.id
	left outer join billstatus b on (v.billnumber = b.number and v.billtype = b.billtype and v.billsession = b.session)
	where personid=#{id}
	order by pv.date desc
	limit 3;
END_QUERY
			ans.push(self.find_by_sql(sql2))
		end
		return ans
	end

end

