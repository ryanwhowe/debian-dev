
alias cat="batcat"
alias bat="batcat"

alias pad="code ~/ScratchPad.md"

alias ls="exa"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -l -a"

alias fortunes="echo \"\" && fortune rules DS9 TNG VOY clonewars startrek && echo \"\""

export PATH="/usr/games:${PATH}"

bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char
