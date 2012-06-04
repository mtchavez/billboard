class Billboard < Sinatra::Base

  configure do
    set :haml, :format => :html5
    set :static, true
  end

  configure :development, :staging do
    enable  :show_exceptions, :dump_errors
    disable :raise_errors,    :clean_trace
  end

  configure :test do
    enable :logging, :raise_errors, :dump_errors
  end

  module MongoHelper

    def mongo
      if ENV['MONGOLAB_URI']
        uri  = URI.parse(ENV['MONGOLAB_URI'])
        p uri
        conn = Mongo::Connection.from_uri(uri)
        db   = conn.db['heroku_app4989206']
      else
        conn = Mongo::Connection.new
        db   = conn['billboard']
      end
    end

  end

  helpers MongoHelper

  get '/' do
    @hot100 = mongo['hot100']
    haml :billboard
  end

end

