require 'open-uri'
require 'pathname'
require 'fileutils'
require 'Sass'

port  = 4567

# html & stylesheets
views = Pathname('site/views')

FileUtils.mkdir_p('output/stylesheets')

Pathname.glob(views.join('**/*.haml')) do |f|
   f = f.relative_path_from(views)
   remote_name = f.to_s[/^([^\.]+)/, 1]
   next if remote_name == 'app'

   open("http://localhost:#{port}/#{remote_name}") do |io|
     open(File.join('output', "#{remote_name}.html"), 'w') do |oio|
       oio << io.read
     end
   end
end

Pathname.glob(views.join('**/*.sass')) do |f|
   f = f.relative_path_from(views)
   remote_name = f.to_s[/^([^\.]+)/, 1]
   next if File.basename(remote_name)[0..0] == '_'

   open("http://localhost:#{port}/#{remote_name}.css") do |io|
     open(File.join('output', "#{remote_name}.css"), 'w') do |oio|
       oio << io.read
     end
   end
end

# public
public_ = Pathname('site/public/.')
FileUtils.cp_r(public_, 'output')
