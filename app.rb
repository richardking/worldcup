require 'sinatra'
require 'sinatra/activerecord'
require 'mysql'

set :views, 'app/views'

class Group < ActiveRecord::Base
end

class Standing < ActiveRecord::Base
end

class User < ActiveRecord::Base
  has_many :users_teams
  has_many :teams, :through => :users_teams

  def associate_with_team(name)
    t = Team.find_by_name(name)
    raise "Could not find team #{name}" unless t
    UsersTeam.create(:user_id => self.id, :team_id => t.id)
  end

  def total_points
    teams.map{|t| (t.wins * 3) + (t.draw) }.inject(&:+)
  end

  def best_possible
    "0"
  end
end

class Team < ActiveRecord::Base
  has_one :standing

  def wins; standing.wins; end
  def losses; standing.losses; end
  def draw; standing.draw; end
end

class UsersTeam < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
end

get '/' do
  @users = User.all
  @teams = Standing.all
  erb :index
end
