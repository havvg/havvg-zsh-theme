source $(dirname $0)/oh-my-git.sh

autoload -U colors && colors

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="015"; fi

PROMPT='$(build_prompt)$(symfony_env_prompt)$(trndsphere_env_prompt)%{$reset_color%} '
RPROMPT='$FG[237]%~%{$reset_color%}'
