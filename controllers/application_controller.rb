require 'sinatra/base'
require 'sinatra/flash'
require 'httparty'
require 'hirb'
require 'slim'
require 'json'

class ApplicationController < Sinatra::Base

enable :sessions
register Sinatra::Flash
use Rack::MethodOverride

set :views, File.expand_path('../../views', __FILE__)
set :public_folder, File.expand_path('../../public', __FILE__)

home = lambda do
  slim :home
end

countdown = lambda do
  request_url = "https://countdown8itos.herokuapp.com/countdown"
  response = HTTParty.get(request_url)
  if response.code != 200
    flash[:notice] = "Lo siento 8ita, pero parece que algo falló. ¿Cuál es la ext de Sistemas?"
    redirect '/'
  else
    results = JSON.parse(response.body)
    @days_left = results['days_left']
    @message = results['message']
  end
  slim :countdown
end

movies = lambda do
  request_url = "https://countdown8itos.herokuapp.com/movies"
  response = HTTParty.get(request_url)
  if response.code != 200
    flash[:notice] = "Lo siento 8ita, pero parece que algo falló. ¿Cuál es la ext de Sistemas?"
    redirect '/'
  else
    results = JSON.parse(response.body)
    @movies = results
  end
  slim :movies
end

events = lambda do
  request_url = "https://countdown8itos.herokuapp.com/events"
  response = HTTParty.get(request_url)
  if response.code != 200
    flash[:notice] = "Lo siento 8ita, pero parece que algo falló. ¿Cuál es la ext de Sistemas?"
    redirect '/'
  else
    results = JSON.parse(response.body)
    @events = results
  end
  slim :events
end

get '/', &home
get '/countdown', &countdown
get '/movies', &movies
get '/events', &events
end
