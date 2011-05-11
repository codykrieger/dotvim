task :clean do
  system "git clean -dfx"
end

desc "Update the documentation"
task :update_docs do
  puts "Updating VIM Documentation..."
  system "vim -e -s <<-EOF\n:helptags ~/.vim/doc\n:quit\nEOF"
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
  system "git pull"
  system "git submodule update --init"
  system "git submodule update"
end

task :default => [:update_docs, :link_vimrc]
