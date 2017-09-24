if [ -f /home/default/etc/zshrc ] ; then
    . /home/default/etc/zshrc
fi

[ -n "`alias run-help`" ] && unalias run-help
autoload -U run-help

umask 022

# alias
if [ -f ~/.zaliases ] ; then
    source ~/.zaliases
fi

### prompt
setopt prompt_subst
PROMPTCOLOR=31
ESC=$(print -Pn '\e')
BELL=$(print -Pn '\a')

# タイトルの設定
case $TERM in
dumb|emacs|sun) unset XTITLE ;;
vt100|[Exk]term*|rxvt|cygwin)
	XTITLE=$ESC']2;$TERM %n@%m:%~'$BELL$ESC']1;%m:%.'$BELL
;;
screen)	XTITLE=$ESC'k%n@%m:%.'$ESC\\ ;;
esac

# ターム内のプロンプトの設定
case $TERM in
dumb|emacs|sun) PROMPT='%n@%m:%3~ %(!.#.$) ' ;;
*)
#if ( which sed >& /dev/null )
#then
#    name_s=`echo $USER | sed 's/\(^....\).*$/\1/'`
#    host_s=`echo $HOST | sed 's/\(^...\).*$/\1/'`
#else
    name_s=`echo $USER`
    host_s=`echo $HOST`
#fi
if [ "`hostname`" = "easter" ]
then
    PROMPT="$"
elif [[ $TERM = "cygwin" ]]
then
    PROMPT='%{'$XTITLE'[$[31+$RANDOM % 6]m%}$name_s@$host_s:%2~%(!.#.$)%{[m%} '
    RPROMPT='%{'$XTITLE'[$[31+$RANDOM % 6]m%}$%7~%{[m%} '
else
    PROMPT='%{'$XTITLE'[m%}$name_s@$host_s:%4~%(!.#.$) '
fi
;;
esac

unset XTITLE
unset ESC
unset BELL

# Some environment variables
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
export USER=$USERNAME
export HOSTNAME=$HOST
export PYTHONSTARTUP=${HOME}/.pythonrc

### bindkey
# bindkey -v             # vi key bindings
bindkey -e               # emacs key bindings

## Bindkey you may think it's usefull
bindkey ' ' magic-space  # also do history expansino on space
bindkey -s "^xs" '\C-e"\C-asu -c "'
#bindkey -s "^xd" "$(date '+-%d_%b')"
bindkey -s "^xd" "$(date '+-%Y%m%d')"
#bindkey -s "^xf" "$(date '+-%D'|sed 's|/||g')"
bindkey -s "^xp" "\$(pwd\)/"
bindkey -s "^xw" "\C-a \$(which \C-e\)\C-a"

# ctrl+j で コマンドの途中からヒストリを呼び出す
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
bindkey "^J" history-beginning-search-backward-end

if ( which dircolors >& /dev/null ); then
    if [ -f ~/.dircolors ] ; then
	eval `dircolors --sh ~/.dircolors`
    fi
    export LS_COLORS="${LS_COLORS}:*~=01;42:*#=01;42:*%=01;42"
#MAC用設定
elif ( which gdircolors >& /dev/null ); then
    if [ -f ~/.dircolors ] ; then
	eval `gdircolors --sh ~/.dircolors`
    fi
    export LS_COLORS="${LS_COLORS}:*~=01;42:*#=01;42:*%=01;42"
else

# lsの色の設定
# export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export LS_COLORS="di=34;1:*.pdf=31:\
*~=32;1:*#=32;1:*%=32;1:\
*README=31;4:*eadme=31;4:\
*.c=31:*.cc=31:*.cpp=31:*.C=31:*.cxx=31:*.h=31:*.o=32:*Makefile=31;43:\
*.html=31:*.htm=31:*.shtml=31:*.tex=31:*.lyx=31:*.mgp=31:*.pl=31:*.for=31:\
*.tar=01;31:*.tgz=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.rpm=01;31:*.lzh=01;31:*.zip=01;31:\
*.jpg=35:*.jpeg=35:*.gif=35:*.bmp=35:*.JPG=35:*.JPEG=35:*.GIF=35:*.BMP=35:\
*.eps=35:*.ppm=35:*.xbm=35:*.xpm=35:*.tif=35:\
*.mpg=01;37:*.mpeg=01;37:*.avi=01;37:*.MPG=01;37:*.MPEG=01;37:*.AVI=01;37:\
or=31;7"
#
fi

# Color completion.
export ZLS_COLORS=$LS_COLORS
zmodload -ui complist

###
# Set shell options

# 親プロセスが死んでも子プロセスが死なない
setopt nohup

# コマンドを訂正して下さる
setopt correct

# ファイル名も訂正して下さる
setopt correct_all

# 複数のタームで実行したコマンドのヒストリを共有化する
setopt share_history

# 直前と同じコマンドを入力した場合，ヒストリに入れない
setopt hist_ignore_dups

# コマンドの不要な空白を削除してヒストリに登録
setopt hist_reduce_blanks

# historyコマンドをヒストリに登録しない
setopt hist_no_store

# スペースで始まるコマンドをヒストリに登録しない
setopt hist_ignore_space

# コマンドの開始時間，経過時間をヒストリに保存
setopt extended_history  

# リダイレクション (>) で上書きしない
# >! で強制書き込み
# setopt no_clobber

# エラーの際のビープ音を鳴らさない
setopt no_beep

# 「#」 「~」 「^」を特殊文字として使用する
setopt extended_glob

# 補完候補をスッキリ表示
setopt list_packed

# cd を省略
setopt auto_cd

# 変数をディレクトリパスとして利用する
setopt auto_name_dirs

# cd コマンドで自動的にpushdする
setopt auto_pushd

# pushdの重複を防ぐ
setopt pushd_ignore_dups 

# popdでスタックの内容を表示しない
setopt pushd_silent

# 日本語のファイル名も補完リストで表示
setopt print_eight_bit

# rm で * を使う際に聞き返してこない
setopt rm_star_silent

# ファイル名中の数字を数字としてソート
setopt numeric_glob_sort

## TAB で順に補完候補を切り替える
# setopt auto_menu 
## TAB で順に補完候補を切り替えない
setopt noautomenu

# Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
# bindkey "^[[Z" reverse-menu-complete 

# 補完時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 

setopt sh_word_split
setopt auto_param_keys
setopt no_list_ambiguous
#setopt dvorak

[[ $EMACS = t ]] && unsetopt zle

#zstyle ':completion:*:complete:ssh:*:hosts' hosts $hosts
# The following lines were added by compinstall

#zstyle ':completion:*' completer _oldlist _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' completer _oldlist  _expand _complete _ignored _match _prefix

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' match-original both
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} m:{a-zA-Z}={A-Za-z}' 'm:{a-z}={A-Z} m:{a-zA-Z}={A-Za-z}' 'm:{a-z}={A-Z} m:{a-zA-Z}={A-Za-z}' 'm:{a-z}={A-Z} m:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' max-errors 1 numeric
zstyle ':completion:*' old-list _complete _approximate _correct _match _expand
zstyle ':completion:*' original true
zstyle :compinstall filename '~/.zshrc'
#zstyle ':completion:*:default' menu select=1

# 補完機能が強力になる
autoload -U compinit
compinit

# 日本語名の directory へ移動
ncd(){ builtin cd "`echo $@ | nkf -s`"}
nls(){ ls $@ | nkf}
# nxmms() { /usr/bin/xmms "`echo $@ | nkf -s`"}
# nplaympeg() { plaympeg "`echo $@ | nkf -s`"}

# export LM_LICENSE_FILE=1700@collabo4:7182@collabo4:1717@133.11.58.5:1709@karafuto

if [[ -n $SSH_CLIENT || -n $DISPLAY ]]; then
	LANG=ja_JP.UTF-8 export LANG
	LC_ALL=ja_JP.UTF-8 export LC_ALL
	XMODIFIERS=@im=uim export XMODIFIERS
fi

# LC_ALL=C
# ibus-daemon -drx

case $HOST in
    molokai )
	export CUDA_HOME=/usr/local/cuda-8.0
	export PATH=$CUDA_HOME/bin:$PATH
	export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
    . /opt/torch/install/bin/torch-activate
	;;
    hawaii ) 
	export CUDA_HOME=/usr/local/cuda-8.0
	export PATH=$CUDA_HOME/bin:$PATH
	export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

    export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
    export LIBLEPT_HEADERSDIR=/usr/local/include
    ;;
    caster | king)
	export PATH=/usr/local/cuda/bin:$PATH
	export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
	
	export PATH=~/torch/bin:$PATH
	export LD_LIBRARY_PATH=~/torch/lib:$LD_LIBRARY_PATH 
	
	source /usr/local/bin/virtualenvwrapper.sh
	export WORKON_HOME=~/.virtualenvs
    
    export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
    export LIBLEPT_HEADERSDIR=/usr/local/include

	export PATH=/home/satoshi/local/src/Quartus_Prime_Lite/quartus/bin:$PATH
    ;;    
    Texas.*)
	source /usr/local/bin/virtualenvwrapper.sh
	export WORKON_HOME=~/.virtualenvs
	export PATH=/Users/satoshi/local/bin:$PATH
    ;;
    * )
      export PATH=/opt/mentor/modeltech_SE10.4c/bin:$PATH
      export PATH=/opt/synopsys/syn_vI-2013.12-SP2/bin:$PATH
      export PATH=/opt/synopsys/vcs-mx_vI-2014.03-SP1-5/bin:$PATH
      export PATH=/opt/synopsys/pts_vH-2013.06-SP5-5/bin:$PATH
	;;
esac

export PATH=/home/satoshi/local/bin:$PATH

# 以下はhttp://d.hatena.ne.jp/oovu70/20120405/p1を参考
# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
# # 色の設定
# export LSCOLORS=Exfxcxdxbxegedabagacad
# # 補完時の色の設定
# export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# # ZLS_COLORSとは？
# export ZLS_COLORS=$LS_COLORS
# # lsコマンド時、自動で色がつく(ls -Gのようなもの？)
# export CLICOLOR=true
# # 補完候補に色を付ける
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

### Prompt ###
# プロンプトに色を付ける
autoload -U colors; colors
# 一般ユーザ時
# tmp_prompt="%{${fg[cyan]}%}%n%# %{${reset_color}%}"
tmp_prompt="%{%}%{${fg[green]}%}$name_s%{${fg[white]}%}@%{${fg[white]}%}$host_s%{${reset_color}%}:%4~%(!.#.$) "
tmp_prompt2="%{%}%{${fg[green]}%}$name_s%{${fg[white]}%}@%{${fg[green]}%}$host_s%{${reset_color}%}:%4~%(!.#.$) "
tmp_prompt3="%{%}%{${fg[green]}%}$name_s%{${fg[white]}%}@%{${fg[yellow]}%}$host_s%{${reset_color}%}:%4~%(!.#.$) "
tmp_prompt4="%{%}%{${fg[green]}%}$name_s%{${fg[white]}%}@%{${fg[red]}%}$host_s%{${reset_color}%}:%4~%(!.#.$) "
tmp_prompt5="%{%}%{${fg[green]}%}$name_s%{${fg[white]}%}@%{${fg[cyan]}%}$host_s%{${reset_color}%}:%4~%(!.#.$) "
# tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

# case $HOST in
#    adman   ) PROMPT=$tmp_prompt4 ;;
#    cooper    ) PROMPT=$tmp_prompt5 ;; 
#    molokai    ) PROMPT=$tmp_prompt3 ;;
#    * ) PROMPT=$temp_prompt2 ;;
# esac
# case $HOST in
#    localhost ) col='0' ;;       # white (default)
#    adman   ) col='34' ;;       # yellow
#    cooper    ) col='35' ;;      # magenta
#    molokai    ) col='36' ;;      # cyan
#    * ) col='31' ;;              # red
# esac

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

# PROMPT=$tmp_prompt    # 通常のプロンプト
# PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
# RPROMPT=$tmp_rprompt  # 右側のプロンプト
# SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト

# SSHログイン時のプロンプト
# -n string: stringの文字列長が0より大ならば真とする
if [ -n "${REMOTEHOST}${SSH_CONNECTION}" ]; then
    if [ ${HOST} = "molokai" -o ${HOST} = "hawaii" ]; then
        PROMPT=$tmp_prompt2
    elif [ ${HOST} = "mai" -o ${HOST} = "camel" -o ${HOST} = "bateau" ]; then
        PROMPT=$tmp_prompt3
    elif [ ${HOST} = "menorca" ]; then
        PROMPT=$tmp_prompt5
    else
        PROMPT=$tmp_prompt4
    fi
else #not ssh
    PROMPT=$tmp_prompt
fi
### Title (user@hostname) ###
# case "${TERM}" in
# kterm*|xterm*|)
#   precmd() {
#     echo -ne "\033]0;${USER}@${HOST%%.*}\007"
#   }
#   ;;
# esac
#

stty -ixon
