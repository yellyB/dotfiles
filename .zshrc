# ───── 기본 설정 ─────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel9k/powerlevel9k"
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
