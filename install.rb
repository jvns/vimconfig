dirname = File.expand_path(File.dirname(__FILE__))
if File.exist?('~/.vimrc')
  `mv ~/.vimrc ~/.vimrc.bak`
end
if File.exist?('~/.vim')
  `mv ~/.vim ~/.vim.bak`
end
`ln -s #{dirname}/vimrc ~/.vimrc`
`ln -s #{dirname}/dotvim ~/.vim`
