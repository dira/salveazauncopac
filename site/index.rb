require 'rubygems'
require 'haml'
require 'sinatra'
require 'uri'

module Sinatra
  module Sass
    def render_sass(content, options = {})
      ::Sass::Engine.new(content, options).render
    end
  end
end

def mail_link(address)
  URI.escape "mailto:#{address}?subject=Dezabonare pliante promotionale&body=Buna ziua,

va rog sa nu mai trimiteti pliante promotionale la adresa:

*** adresa ta ***

Va multumesc!"
end

get '/stylesheets/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass "stylesheets/#{params["name"]}".to_sym, :sass => {:style => :expanded, :load_paths => ["views/stylesheets/"]}
end

get '/*' do
  name = params["splat"][0]
  name = "index" if name.empty?

  haml name.to_sym, :layout => :app
end
