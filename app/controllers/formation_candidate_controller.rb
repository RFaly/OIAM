class FormationCandidateController < ApplicationController
  def index
  	@formations = Formation.all
  end

  def date_rdv
  	@formation = Formation.find_by(params[:formation_id])

  	date = DateTime.now.utc
    @dates = []
    i = 1
    while @dates.length < 2
      tmp_date = date.next_day(i)
      if !tmp_date.saturday?
        if !tmp_date.sunday?
          long_date = l tmp_date, :format => :long
          @dates.push({long:long_date[0 .. -7],short:"#{tmp_date.day}-#{tmp_date.month}-#{tmp_date.year}"})
        end
      end
      i += 1
    end

  end

  def save_rdv
  	
  end

end
