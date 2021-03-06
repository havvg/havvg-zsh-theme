: ${home_icon:=''} # 

: ${omg_is_a_git_repo_symbol:=''} # 

: ${omg_has_untracked_files_symbol:=''}        #                ?    
: ${omg_has_adds_symbol:=''}
: ${omg_has_deletions_symbol:=''}
: ${omg_has_cached_deletions_symbol:=''}
: ${omg_has_modifications_symbol:=''}
: ${omg_has_cached_modifications_symbol:=''}

: ${omg_ready_to_commit_symbol:=''}            #   →
: ${omg_is_on_a_tag_symbol:=''}                #   

: ${omg_needs_to_merge_symbol:='ᄉ'}
: ${omg_detached_symbol:=''}

: ${omg_has_diverged_symbol:=''}               #   
: ${omg_can_fast_forward_symbol:=''} #   
: ${omg_should_push_symbol:=' '}                #    

: ${omg_not_tracked_branch_symbol:=' '}

: ${omg_rebase_tracking_branch_symbol:=''}     #   
: ${omg_merge_tracking_branch_symbol:=''}      #  
: ${omg_has_stashes_symbol:=''}
: ${omg_has_action_in_progress_symbol:=''}     #                  

: ${prompt_eol_symbol:=""}
: ${prompt_separator:=""}

: ${rprompt_fol_symbol:=""}
: ${rprompt_separator:=""}


function enrich_append {
    local symbol=${1}
    local color=${2:-$FG[015]}

    echo -n " ${color}${symbol}%{$reset_color%}"
}

function enrich_append_if {
    if [[ true == ${1} ]]; then
        enrich_append "${2}" "${3}"
    fi
}

function enrich_append_unless {
    if [[ false == ${1} ]]; then
        enrich_append "${2}" "${3}"
    fi
}

function enrich_prepend {
    local symbol=${1}
    local color=${2:-$FG[015]}

    echo -n "${color}${symbol} "
}

function custom_build_prompt {
    local enabled=${1}
    local current_commit_hash=${2}
    local is_a_git_repo=${3}
    local current_branch=${4}
    local detached=${5}
    local just_init=${6}
    local has_upstream=${7}
    local has_modifications=${8}
    local has_modifications_cached=${9}
    local has_adds=${10}
    local has_deletions=${11}
    local has_deletions_cached=${12}
    local has_untracked_files=${13}
    local ready_to_commit=${14}
    local tag_at_current_commit=${15}
    local is_on_a_tag=${16}
    local has_upstream=${17}
    local commits_ahead=${18}
    local commits_behind=${19}
    local has_diverged=${20}
    local should_push=${21}
    local will_rebase=${22}
    local has_stashes=${23}
    local action=${24}

    local blue="%{$fg[blue]%}"
    local green="%{$fg[green]%}"
    local red="%{$fg[red]%}"
    local white="$FG[015]"
    local yellow="%{$fg[yellow]%}"

    local prompt="${white}"

    if [[ true == ${is_a_git_repo} ]]; then
        if [[ true == ${is_on_a_tag} ]]; then
            prompt+=$(enrich_append ${omg_is_on_a_tag_symbol} "${blue}")
            prompt+=$(enrich_append ${tag_at_current_commit} "${blue}")
        else
            if [[ true == ${detached} ]]; then
                prompt+=$(enrich_append ${omg_detached_symbol} "${blue}")
                prompt+=$(enrich_append "${current_commit_hash:0:7}" "${blue}")
            else
                if [[ false == ${has_upstream} ]]; then
                    prompt+=$(enrich_append ${omg_not_tracked_branch_symbol} "${blue}")
                else
                    prompt+=$(enrich_append "${current_branch}" "${blue}")
                    prompt+=$(enrich_append_unless ${will_rebase} "${omg_merge_tracking_branch_symbol}" "${red}")
                    prompt+=$(enrich_append_if ${has_diverged} ${omg_has_diverged_symbol} "${yellow}")
                fi
            fi
        fi
    fi

    echo "${prompt}"
}

function custom_build_rprompt() {
    local enabled=${1}
    local current_commit_hash=${2}
    local is_a_git_repo=${3}
    local current_branch=${4}
    local detached=${5}
    local just_init=${6}
    local has_upstream=${7}
    local has_modifications=${8}
    local has_modifications_cached=${9}
    local has_adds=${10}
    local has_deletions=${11}
    local has_deletions_cached=${12}
    local has_untracked_files=${13}
    local ready_to_commit=${14}
    local tag_at_current_commit=${15}
    local is_on_a_tag=${16}
    local has_upstream=${17}
    local commits_ahead=${18}
    local commits_behind=${19}
    local has_diverged=${20}
    local should_push=${21}
    local will_rebase=${22}
    local has_stashes=${23}
    local action=${24}

    local blue="%{$fg[blue]%}"
    local grey="%{$FG[237]%}"
    local green="%{$fg[green]%}"
    local red="%{$fg[red]%}"
    local white="%{$FG[015]%}"
    local yellow="%{$fg[yellow]%}"

    local background_color="%{$BG[039]%}"

    local fol_symbol="%{$FG[039]%}${rprompt_fol_symbol}"
    local separator="${grey}${rprompt_separator}"

    local rprompt=""

    if [[ true == ${is_a_git_repo} ]]; then
        if [[ true == ${has_upstream} ]]; then
            if [[ true == ${has_diverged} ]]; then
                if [[ ${commits_behind} -gt 0 ]]; then
                    rprompt+=$(enrich_prepend ${omg_can_fast_forward_symbol} "${white}")
                fi
            fi

            if [[ ${commits_ahead} -gt 0 && false == ${has_diverged} ]]; then
                rprompt+=$(enrich_prepend "${omg_should_push_symbol}" "${white}")
            fi
        fi
    fi

    if [[ -n "${home_icon}" && "$HOME" == $(pwd) ]]; then
        rprompt+="${white}${home_icon}"
    else
        rprompt+="${grey}%2~"
    fi

    if [[ true == ${is_a_git_repo} ]]; then
        if [ -n "${omg_is_a_git_repo_symbol}" ]; then
            rprompt+=$(enrich_prepend " ${omg_is_a_git_repo_symbol}" "${white}")
        fi
    fi

    echo "${fol_symbol}${background_color} ${rprompt}%E%{$reset_color%}"
}
