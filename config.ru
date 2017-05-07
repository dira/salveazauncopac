require 'rack/rewrite'
require_relative 'rack_haml_sass_generator'

use Rack::SiteGenerator, :destination_path => "public"

use Rack::Rewrite do
  rewrite '/', '/index.html'
end

use Rack::Static, :urls => [/\/.+/], :root => "public"
run lambda { |env| [200, { 'Content-Type' => 'text/html', 'Cache-Control' => "public, max-age=#{60 * 60 * 24}" },
             File.open('public/index.html', File::RDONLY)] }
