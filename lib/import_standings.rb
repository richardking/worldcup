require 'httparty'
require 'sinatra/activerecord'

class Group < ActiveRecord::Base
end

class Importer
  url = "http://data.t.bleacherreport.com/WorldChampionshipXZ/Soccer/WorldChampionshipXZ_2014/standings.json"

  a = HTTParty.get(url)
  puts a.parsed_response.inspect
  puts a.parsed_response["category"].first["tournamentGroup"].first["tournament"].inspect
  a.parsed_response["category"].first["tournamentGroup"].first["tournament"].each do |group|
    q = Group.find_by_turner_id(group["tournamentId"])
    puts q.inspect

  end
end
