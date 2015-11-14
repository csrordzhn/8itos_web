require 'httparty'

module WebHelper

  def get_countdown
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
  end

  def movie_list
    request_url = "https://countdown8itos.herokuapp.com/movies"
    response = HTTParty.get(request_url)
    if response.code != 200
      flash[:notice] = "Lo siento 8ita, pero parece que algo falló. ¿Cuál es la ext de Sistemas?"
      redirect '/'
    else
      results = JSON.parse(response.body)
      @movies = results
    end
  end

  def add_movie_to_list
    request_url = "https://countdown8itos.herokuapp.com/add_movie"
    body = { title: params[:title], viewed: params[:viewed], comments: params[:comments] }
    options = {
      body: body.to_json,
      headers: { 'Content_Type' => 'application/json'}
    }
    puts body.to_json
    response = HTTParty.post(request_url, options)
    if response.code !=201
      flash[:notice] = "Lo siento 8ita, pero parece que algo falló. ¿Cuál es la ext de Sistemas?"
      redirect '/add_movie'
    else
      redirect '/movies'
    end
  end

  def event_list
    request_url = "https://countdown8itos.herokuapp.com/events"
    response = HTTParty.get(request_url)
    if response.code != 200
      flash[:notice] = "Lo siento 8ita, pero parece que algo falló. ¿Cuál es la ext de Sistemas?"
      redirect '/'
    else
      results = JSON.parse(response.body)
      @events = results
    end
  end

  def add_event_to_list
    request_url = "https://countdown8itos.herokuapp.com/add_event"
    body = { year: params[:year], month: params[:month], day: params[:day], desc: params[:description] }
    options = {
      body: body.to_json,
      headers: { 'Content_Type' => 'application/json'}
    }
    puts body.to_json
    response = HTTParty.post(request_url, options)
    if response.code !=201
      flash[:notice] = "Lo siento 8ita, pero parece que algo falló. ¿Cuál es la ext de Sistemas?"
      redirect '/add_event'
    else
      redirect '/events'
    end
  end

  def add_message_to_list
    request_url = "https://countdown8itos.herokuapp.com/add_message"
    body = { message: params[:message], category: params[:category] }
    options = {
      body: body.to_json,
      headers: { 'Content_Type' => 'application/json'}
    }
    puts body.to_json
    response = HTTParty.post(request_url, options)
    if response.code !=201
      flash[:notice] = "Algo falló. Revisar base de datos."
    end
    redirect '/'
  end
end
