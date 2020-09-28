if @cadreInfo.nil?
  json.null! # or json.nil!
else
  json.score_potential @cadreInfo.score_potential
end
