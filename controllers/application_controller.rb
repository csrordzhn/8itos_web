require 'sinatra/base'
require 'sinatra/flash'
require 'hirb'
require 'slim'
require 'json'

class ApplicationController < Sinatra::Base
include WebHelper

enable :sessions
register Sinatra::Flash
use Rack::MethodOverride

set :views, File.expand_path('../../views', __FILE__)
set :public_folder, File.expand_path('../../public', __FILE__)

home = lambda { slim :home }

countdown = lambda do
  get_countdown
  slim :countdown
end

movies = lambda do
  movie_list
  slim :movies
end

get_movie = lambda { slim :add_movie }

add_movie = lambda { add_movie_to_list }

events = lambda do
  event_list
  slim :events
end

get_event = lambda { slim :add_event }

add_event = lambda { add_event_to_list }

get_message = lambda { slim :add_message }

add_message = lambda { add_message_to_list }

# Web Routes
get '/', &home

get '/countdown', &countdown

get '/movies', &movies
get '/add_movie', &get_movie
post '/add_movie', &add_movie

get '/events', &events
get '/add_event', &get_event
post '/add_event', &add_event

get '/add_message', &get_message
post '/add_message', &add_message
end
