# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ───── 기본 설정 ─────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# ───── PATH 설정 ─────
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/flutter/bin:/Downloads/flutter/bin:/Users/oto/Documents/flutter/bin:$PATH"

# ───── Neovim 설정 ─────
if command -v nvim &> /dev/null; then
  alias vi="nvim"
  export EDITOR='nvim'
fi

alias mx="tmuxinator"

# ───── 기타 기본 유저 설정 ─────
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# zoxide 
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# fzf (fuzzy finder)
source <(fzf --zsh)
export FZF_DEFAULT_OPTS='--preview "bat --color=always {}"'

# pyenv + pyenv-virtualenv
if command -v pyenv &> /dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  alias ac="source activate"
fi

# 비공개 설정 분리
source ~/.zshrc_secret

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
