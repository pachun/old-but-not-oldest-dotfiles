function use_vim_instead_of_emacs_hotkeys_on_the_command_line {
  bindkey -v

  switch_to_vim_command_mode=jj
  bindkey -M viins $switch_to_vim_command_mode vi-cmd-mode
}

function syntax_highlight_commands_typed_at_zsh_prompt {
  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
}

function enable_colorized_output_from_cli_commands {
  export CLICOLOR=1
}

function use_custom_prompt {
  # https://scriptingosx.com/2019/07/moving-to-zsh-06-customizing-the-zsh-prompt/
  function allow_prompt_string_interpolation {
    setopt promptsubst
  }

  function directory {
    echo "%F{blue}%1~%f "
  }

  function vim_mode {
    if [[ $VIMODE == 'vicmd' ]]; then
      echo "%F{red}✘%f "
    else
      echo "%F{green}✔%f "
    fi
  }

  function keep_vim_mode_current {
    function zle-line-init zle-keymap-select {
      VIMODE=$KEYMAP
      zle reset-prompt
    }

    function editing {
      return $VIMODE == 'main'
    }

    zle -N zle-line-init
    zle -N zle-keymap-select
  }

  function status_colored_git_branch {
    if [ -d ".git" ]; then
      git_branch=$(git branch | awk '/\*/ { print $2; }')
      git_status=$(git status)
      if [ -n "$(echo $git_status | grep "Changes not staged")" ]; then
        echo "%F{red}$git_branch%f "
      elif [ -n "$(echo $git_status | grep "rebasing")" ]; then
        echo "%F{red}(rebase in progress)%f "
      elif [ -n "$(echo $git_status | grep "Changes to be committed")" ]; then
        echo "%F{yellow}$git_branch%f "
      elif [ -n "$(echo $git_status | grep "Untracked files")" ]; then
        echo "%F{cyan}$git_branch%f "
      else
        echo "%F{green}$git_branch%f "
      fi
    else
      echo ""
    fi
  }

  allow_prompt_string_interpolation
  keep_vim_mode_current

  PROMPT='$(directory)$(status_colored_git_branch)$(vim_mode)'
}

function alias_git_commands {
  alias g="hub"
  alias gs="git status"
  alias pr="git pull-request"
  alias mr="lab mr create origin develop"
  alias gco="git checkout"
  alias gb="git branch"
  alias gr="git rebase"
  alias gri="git rebase -i"
  alias gl="git log"
  alias gm="git merge"

  alias x="gitx"
  alias wip="g add .; g commit -am 'wip' --no-verify"
  alias keepmaster="git branch | grep -v \"master\" | xargs git branch -D"
  alias keepmain="git branch | grep -v \"main\" | xargs git branch -D"
  alias keepdevelop="git branch | grep -v \"develop\" | xargs git branch -D"
}

function autocomplete_git_commands {
  # https://medium.com/@oliverspryn/adding-git-completion-to-zsh-60f3b0e7ffbc
  zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
  fpath=(~/.zsh $fpath)
  autoload -Uz compinit && compinit
}

function alias_rails_commands {
  alias s="bundle exec rspec"
  alias ss="DISABLE_SPRING=true COVERAGE=true bundle exec rspec"
}

function use_neovim {
  alias vim="nvim"
}

use_vim_instead_of_emacs_hotkeys_on_the_command_line
syntax_highlight_commands_typed_at_zsh_prompt
enable_colorized_output_from_cli_commands
use_custom_prompt
alias_git_commands
autocomplete_git_commands
alias_rails_commands
use_neovim

alias e="exit"
alias c="clear"
alias t="tmux"
alias lanip="ifconfig | grep 192 | cut -d ' ' -f 2"

[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
