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
  p @names
  p @num_of_teams
  # Checks whether textarea is empty
  if @names.strip.empty?
    @error = "You haven't entered any names!"
    erb :index, layout: :app_layout
  # Checks the number of teams input for non-digit characters or emptiness
  elsif !(@num_of_teams =~ /\D/).nil? || @num_of_teams.strip.empty? || @num_of_teams.to_i == 0 || @num_of_teams.to_i > @names.split(',').length 
    @error = "Invalid input for number of teams!"
    erb :index, layout: :app_layout
  # Assign teams if checks have been passed  
  else
    @names = @names.split(',')
    @num_of_teams = @num_of_teams.to_i
    # Initialize empty teams
    1.upto(@num_of_teams) do |x|
      session[:teams]["Team #{x}".to_sym] = []
    end
    # Distribute names among teams in a random fashion
    # While there are names, find smallest team and add a random name, remove that name, repeat.
    while @names.length > 0 do
      @shortest = "Team 1".to_sym
      #p "In while shortest set to T1 #{@shortest}"
      session[:teams].each do |key, value|
        if value.length < session[:teams][@shortest].length
          @shortest = key
          p @shortest
        end
      end
      p "Current shortest #{@shortest}"
      p session[:teams]
      @ran_num = rand(0...@names.length)
      session[:teams][@shortest] << @names[@ran_num]
      @names.delete_at(@ran_num)
    end
    #p session[:teams]
    erb :index, layout: :app_layout
  end
end
