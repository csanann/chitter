#file: app.rb
# in progress
require 'pg'
require 'date'
require 'bcrypt'
require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'
require_relative 'lib/peep_repository'
require_relative 'lib/user_repository'

DatabaseConnection.connect('chitter_test')

class Application < Sinatra::Base
  enable :sessions

  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/peep_repository'
    also_reload 'lib/user_repository'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    #process sign up
    erb :signup
  end

  #post '/' do
    # email = params[:email]
    # password = params[:password]
    # user_repository = UserRepository.new
    # user = user_repository.find_by_email(email)

    # if user.password == password
    #   session[:id] = user.id
    #   redirect('/peep')#replace later
    # else
    #   status 400 #or and error msg
    # end
  #end

  post '/signup' do
    #process signup
    password_hash = BCrypt::Password.create(params[:password])
    new_user = User.new(
      name: params[:name],
      username: params[:username],
      email: params[:email],
      password: password_hash
    )
    
    if user_repo.exists?(new_user.email, new_user.username)
      halt 400, 'Error: email or username already exists. Please try again'
    else
      user_repo.create(new_user)
      session[:user_id] = user_repo.find_by_email(new_user.email).id
      erb :account_created
      redirect '/peeps' #to view peeps
    end
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    #process login
    user = user_repo.find_by_email(params[:submitted_email])

    #if user && user.password == params[:submitted_password]
    if user && BCrypt::Password.new(user.password_digest) == params[:submitted_password]
      session[:user_id] = user.id
      erb :login_success
    else
      halt 400, 'Email and password do not match. Please try again'
    end
  end

  get '/peeps/new' do
    #new peep form
    authenticate!
    erb :new_peep
  end

  post '/peeps' do
    #create new peep
    authenticate!

    new_peep = Peep.new(
      content: params[:content],
      time: Time.now,
      user_id: @user.id
    )

    peep_repo.create(new_peep)

    erb :peep_posted
  end

  # get '/peeps' do
  #   #display all peeps
  # end

  # get '/peeps/:id' do
  #   peep = peep_repo.find(params[:id])
  #   halt 404, 'Not Found' unless peep

  #   user = user_repo.find(peep.user_id)
  #   @message = peep.message
  #   @timestamp = peep.timestamp
  #   @name = user.name
  #   @username = user.username

  #   erb :peep
  # end

  # get '/account_page' do
  #   authenticate!
  #   erb :account_page
  # end

  post '/logout' do
    #process logout
    session.clear
    #session[:id] = nil
    redirect '/index'
  end

  #run! if app_file == $0
  #start the server if ruby file executed directly
end
