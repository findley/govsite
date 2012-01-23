class Position < ActiveRecord::Base
	set_table_name "people_votes"

	searchable do
		integer :personid
		string :voteid
		text :description do
			Vote.find(voteid).description
			#votes.map {|vote| vote.description}
		end
		text :bill do
			Vote.find(voteid).findbilltitle
			#bills.map {|bill| vote.fullbilltitle}
		end
	end

	def self.search_with_query(personid, query)
		id = personid.to_i
		query = ActiveRecord::Base.connection.quote('%' + query + '%')
		sql = <<END_QUERY
	select * from people_votes pv
	left join votes v on pv.voteid = v.id
	left outer join billstatus b on (v.billnumber = b.number and v.billtype = b.billtype and v.billsession = b.session)
	where (
		personid=#{id} and
		(
			v.description like #{query} or
			b.fulltitle like #{query}
		)
	)
	limit 150;
END_QUERY
		return self.find_by_sql(sql)
	end
end
