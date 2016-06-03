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
  # Checks whether textarea is empty
  if params[:names].strip.empty?
    @error = "You haven't entered any names!"
    erb :index, layout: :app_layout
  # Checks the number of teams input for non-digit characters or emptiness
  elsif !(params[:num_of_teams] =~ /\D/).nil? || params[:num_of_teams].strip.empty?
    @error = "Invalid input for number of teams!"
    erb :index, layout: :app_layout
  else
    erb :index, layout: :app_layout
  end

end
