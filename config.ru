require 'rack_haml_sass_generator'

use Rack::SiteGenerator, :destination_path => "public"
use Rack::Static, :urls => ["/"], :root => "public"

run lambda{|a| return [404, [], ""]}
