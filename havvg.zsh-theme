source $(dirname $0)/oh-my-git.sh

autoload -U colors && colors

PROMPT='$(build_prompt)$(symfony_env_prompt)$(trndsphere_env_prompt)%{$reset_color%} '
RPROMPT='$(build_prompt "custom_build_rprompt")'
