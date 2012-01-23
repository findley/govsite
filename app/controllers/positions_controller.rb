class PositionsController < ApplicationController
  # GET /positions
  # GET /positions.json
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @positions }
    end
  end

  def search
	id = Person.findidbyname(params[:searchperson])
	if id.length == 1
		@positions = Position.search_with_query(id[0].id,params[:searchtopic])
	else
		sug=[]
		for item in id
			p=Person.find(item.personid)
			sug.push(p.firstname+' '+p.lastname)
		end
		@suggestions = sug
	end

	respond_to do |format|
      		format.html # index.html.erb
      		format.json { render :json => @positions }
    	end
  end

  # GET /positions/1
  # GET /positions/1.json
  def show
    @position = Position.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @position }
    end
  end‏
end
end
