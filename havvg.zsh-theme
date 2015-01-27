if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="015"; fi

PROMPT='$FG[015]$(git_prompt_info)$(git_prompt_status)%{$reset_color%} '
RPROMPT='$FG[237]%~%{$reset_color%}'
LSCOLORS=ExFxCxDxBxegedabagacad

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[blue]%}git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "

ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗"

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}≠"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}-"
