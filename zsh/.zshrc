# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -v
export KEYTIMEOUT=1

cursor_mode() {
    # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'


    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }

    zle-line-init() {
        echo -ne $cursor_beam
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
}

cursor_mode

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
mkdir -p ~/.cache/zsh
compinit -d ~/.cache/zsh/zcompdump

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

#My Aliases
alias ~='cd ~'
alias zshconfig='nvim ~/.zshrc'
alias nvimconfig='nvim ~/.config/nvim/lua/vscode-settings/init.lua'
alias ..='cd ..'
alias ...='cd ../..'
alias h='eval "$(horse)"'
function idea() {
    '/mnt/c/Program Files/JetBrains/IntelliJ IDEA 2025.2.2/bin/idea64.exe' "$@"
}

WINDL=/mnt/c/Users/juyong/Downloads

# grab: copy a Windows download into the current directory
#   grab         newest download
#   grab <text>  newest download whose name contains <text>
#   grab -p      pick one with fzf
grab() {
    local f
    if [[ $1 == -p ]]; then
        f=$(ls -t "$WINDL" | fzf --prompt='grab> ') || return
    else
        f=$(ls -t "$WINDL" | grep -iF -- "${1:-}" | head -1)
    fi
    [[ -n $f ]] || { echo "grab: nothing matches '$1'" >&2; return 1; }
    [[ -e $f ]] && { echo "grab: $f already exists here" >&2; return 1; }
    # /mnt/c marks everything executable; clear it on the copied files
    cp -r -- "$WINDL/$f" . && find "./$f" -type f -exec chmod a-x {} + && echo "grabbed $f"
}
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="$HOME/.local/share/go/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export JAVA_HOME=/opt/jdk-25.0.2
export PATH=$JAVA_HOME/bin:$PATH


export PATH="$HOME/.local/opt/infer/bin:$PATH"
# WezTerm's env var isn't forwarded into WSL; ratatui-image (spotify_player) needs it
# to avoid the Kitty protocol, whose unicode placeholders WezTerm renders as "?"
if [[ $TERM_PROGRAM == WezTerm && -z $WEZTERM_EXECUTABLE ]]; then
  export WEZTERM_EXECUTABLE=wezterm
fi
