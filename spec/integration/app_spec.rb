
#$LOAD_PATH << './features'
require './app'
require 'rspec'
require 'rack/test'
#require 'capybara/rspec'
#require 'features/web_helpers'

RSpec.describe 'Application', type: :feature do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_my_default_route
    get '/'
    assert last_response.ok?
    assert_equal 'Hello world!', last_response.body
  end

#  it 'displays homepage' do
#    get '/'
#    expect(last_response).to be_ok
#    expect(last_response.body).to include("Welcome to Chitter!")
#  end
  context 'GET/sign_up'
    it 'display sign up form' do
      response = get '/sign_up'

      expect(response.status).to eq(200)
      expect(response.body).to include('<form method="POST" action="/sign_up">')
      expect(response.body).to include('<input type="text" name="name" ')
      expect(response.body).to include('<input type="text" name="username" ')
      expect(response.body).to include('<input type="email" name="email" ')
      expect(response.body).to include('<input type="password" name="password" ')
    end
  end

  context 'GET/log_in'
    it 'display log in form' do
      response = get '/log_in'

      expect(response.status).to eq(200)
      expect(response.body).to include('<form method="POST" action="/log_in">')
      expect(response.body).to include('<input type="email" name="submitted_email" ')
      expect(response.body).to include('<input type="password" name="submitted_password" ')  
    end
  end
 
    it 'display create a peep form' do
      response = get '/login/create_peep'

      expect(response.status).to eq(200)
      expect(response.body).to include('<form method="POST" action="/login/create_peep">')
      expect(response.body).to include('<input type="text" name="message" ')
    end

    it 'display a peep' do
      response = get '/log_in/peep'

      expect(response.status).to eq(200)
      expect(response.body).to include('Peep from:')
      expect(response.body).to include(@message)
      expect(response.body).to include(@timestamp)
    end
  end
end 