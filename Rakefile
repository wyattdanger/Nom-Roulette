require 'fileutils'

target = 'www'
backup = 'www.bak'

task 'build' do
  if File.exists? target
    FileUtils.mv target, backup
  end

  if system("frank export --production #{ target }")
    FileUtils.rm_rf backup
    system("yuicompressor --type css www/stylesheets/site.css -o www/stylesheets/site.css")
    puts "Compressed www/css/style.css"
  end
end

task 'deploy' do
  system("rsync -avz ./www/ linode:/var/www/wyattdanger/public/wtf-to-eat/")
end
