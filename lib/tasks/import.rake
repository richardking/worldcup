require 'httparty'

class Group < ActiveRecord::Base
end

class Standing < ActiveRecord::Base
end

task :import do
  url = "http://data.t.bleacherreport.com/WorldChampionshipXZ/Soccer/WorldChampionshipXZ_2014/standings.json"

  a = HTTParty.get(url)
  puts a.parsed_response.inspect
  puts a.parsed_response["category"].first["tournamentGroup"].first["tournament"].inspect
  a.parsed_response["category"].first["tournamentGroup"].first["tournament"].each do |group|
    g = Group.find_by_turner_id(group["tournamentId"]) || Group.new(:turner_id => group["tournamentId"])
    g.name = group["tournamentName"].split(' ')[-2..-1].join(' ')
    g.save
    group["teams"].each do |team|
      t = Team.find_by_turner_id(team["teamId"]) || Team.new(:turner_id => team["teamId"])
      t.name = team["name"]
      t.save
      s = Standing.find_by_team_id(t.id) || Standing.new(:team_id => t.id)
      overall = team["overall"].first
      s.games_played = overall["gamesPlayed"]
      s.wins = overall["wins"]
      s.losses = overall["losses"]
      s.draw = overall["draw"]
      s.goals_for = overall["goalsfor"]
      s.goals_against = overall["goalsagainst"]
      s.rank = overall["rank"]
      s.change = overall["change"]
      s.group_id = g.id
      s.save
    end
  end
end
