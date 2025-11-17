
alias cat="batcat"
alias bat="batcat"

alias pad="code ~/ScratchPad.md"

alias ls="exa --icons --group-directories-first"
alias ll="ls -l -g -h"
alias la="ls -a"
alias lla="ls -l -a -g -h"

alias fortunes="echo \"\" && fortune rules DS9 TNG VOY clonewars startrek && echo \"\""

export PATH="/usr/games:${PATH}"

bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char
