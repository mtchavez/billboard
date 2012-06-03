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

  get '/' do
    haml :billboard
  end

end

