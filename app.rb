#file: app.rb


require 'date'
require 'bcrypt'
require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'
require_relative 'lib/peep_repository'
require_relative 'lib/user_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  enable :sessions

  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/peep_repository'
    also_reload 'lib/user_repository'
  end

  helpers do
    def peep_repo
      @peep_repo ||= PeepRepository.new
    end

    def user_repo
      @user_repo ||= UserRepository.new
    end

    def current_user
      @current_user ||= user_repo.find(session[:user_id]) if session[:user_id]
    end

    def authenticate!
      halt 401, 'Unauthorized' unless current_user
    end
  end

  before do
    @user = current_user
  end

  get '/' do
    @peeps_list = peep_repo.all
    erb :index
  end

  get '/peeps/new' do
    authenticate!
    erb :new_peep
  end

  get '/peeps/:id' do
    peep = peep_repo.find(params[:id])
    halt 404, 'Not Found' unless peep

    user = user_repo.find(peep.user_id)
    @message = peep.message
    @timestamp = peep.timestamp
    @name = user.name
    @username = user.username

    erb :peep
  end

  post '/peeps' do
    authenticate!

    new_peep = Peep.new(
      content: params[:content],
      time: Time.now,
      user_id: @user.id
    )

    peep_repo.create(new_peep)

    erb :peep_posted
  end

  get '/signup' do 
    erb :signup
  end

  post '/signup' do
    new_user = User.new(
      name: params[:name],
      username: params[:username],
      email: params[:email],
      password: params[:password]
    )

    if user_repo.exists?(new_user.email, new_user.username)
      halt 400, 'Error: email or username already exists. Please try again'
    else
      user_repo.create(new_user)
      session[:user_id] = user_repo.find_by_email(new_user.email).id
      erb :account_created
    end
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    user = user_repo.find_by_email(params[:submitted_email])

    if user && user.password == params[:submitted_password]
      session[:user_id] = user.id
      erb :login_success
    else
      halt 400, 'Email and password do not match. Please try again'
    end
  end

  get '/account_page' do
    authenticate!
    erb :account_page
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end
