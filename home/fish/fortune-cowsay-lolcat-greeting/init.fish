function fish_greeting
  set -l toon (random choice {default,bud-frogs,dragon,dragon-and-cow,elephant,moose,stegosaurus,tux,vader})
  fortune -s | cowsay -f $toon | lolcat
end
