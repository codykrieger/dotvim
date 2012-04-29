task :install do
  puts "Installing awesomeness!!!...\n"

  system "git submodule update --init > /dev/null"
  system "git submodule update > /dev/null"

  Rake::Task['pull'].execute
  Rake::Task['update_docs'].execute
  Rake::Task['link_vimrc'].execute
end

task :clean do
  system "git clean -dfx"
end

desc "Update the documentation"
task :update_docs do
  puts "Updating VIM Documentation..."
  system "vim -e -s <<-EOF\n:helptags ~/.vim/doc\n:quit\nEOF"

  puts "Ignoring documentation content in submodules..."
  system "git submodule -q foreach 'echo \"git config submodule.$path.ignore untracked\"' > /dev/null"
end

desc "link vimrc to ~/.vimrc"
task :link_vimrc do
  %w[ vimrc gvimrc ].each do |file|
    dest = File.expand_path("~/.#{file}")
    unless File.exist?(dest)
      ln_s(File.expand_path("../#{file}", __FILE__), dest)
    end
  end
end

desc "Pull latest changes"
task :pull do
  puts "Pulling..."
  system "git pull"

  puts "Updating submodules..."
  system "git submodule update --init > /dev/null"
  system "git submodule foreach git checkout master > /dev/null"
end

task :default => [:pull, :update_docs]
