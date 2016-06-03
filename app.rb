require 'sinatra'
require 'sinatra/reloader'

enable :sessions

before do
  session[:teams] ||= {}
end

get '/' do
  erb :index, layout: :app_layout
end

post '/' do
  @names = params[:names]
  @num_of_teams = params[:num_of_teams]
  # Checks whether textarea is empty
  if @names.strip.empty?
    @error = "You haven't entered any names!"
    erb :index, layout: :app_layout
  # Checks the number of teams input for non-digit characters or emptiness
  elsif !(@num_of_teams =~ /\D/).nil? || @num_of_teams.strip.empty? || @num_of_teams.to_i > @names.strip.length
    @error = "Invalid input for number of teams!"
    erb :index, layout: :app_layout
  # Assign teams if checks have been passed  
  else
    @names = @names.split(',')
    @num_of_teams = @num_of_teams.to_i
    # Initialize empty teams
    1.upto(@num_of_teams) do |x|
      session[:teams]["Team #{x}".to_sym] = 0
    end
    # Distribute names among teams in a random fashion
#    while @names.length > 0
#      
#    end
    p session[:teams]
    erb :index, layout: :app_layout
  end

end
