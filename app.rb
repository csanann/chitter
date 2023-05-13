#file: app.rb

require 'sinatra/base'

class Application < Sinatra::Base
    
    get '/' do
        return 'Hello, world xxx!'
    end
end