desc "Deploy"
task :deploy => :htmlize do
  config = YAML.load_file("config.yml")
  (p 'path not found in config' || exit) if !config["path"]

  p 'copying..'
  `rsync -Cavz output/ salveazauncopac.ro:#{config["path"]}`
  p 'done'

  FileUtils.rm_rf 'output'

  # stop server
  system "kill $(lsof -t -i :4567)"
end

desc "Generate the website"
task :htmlize do
  system "cd site && (ruby index.rb &)"
  sleep 5 # allow the server to initialize
  load 'htmlize.rb'
end
