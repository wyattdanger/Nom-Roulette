require 'fileutils'

target = 'www'
backup = 'www.bak'

task 'build' do
  if File.exists? target
    FileUtils.mv target, backup
  end

  if system("frank export --production #{ target }")
    FileUtils.rm_rf backup

    css = "www/stylesheets/site.css"
    js  = "www/javascripts/app.js"

    system("yuicompressor --type css #{ css } -o #{ css }")
    puts "Compressed #{ css }"

    system("yuicompressor --type js #{ js } -o #{ js }")
    puts "Compressed #{ js }"
  end
end

task 'deploy' do
  system("rsync -avz ./www/ linode:/var/www/wyattdanger/public/wtf-to-eat/")
end
