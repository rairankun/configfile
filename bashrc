# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
PS1='\[\033[01;31m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]\n\$ '

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
#    ;;
#*)
#    ;;
#esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"

    alias ls='ls -F --color=always'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'

    alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Added by Rikita
#export PATH=$PATH:$HOME/bin
export LESSEDIT='vi %f' 

# My shortcut (Overwrite existing command) --------------------------------
alias ll='ls -hl'
alias la='ls -A'
#alias lr='ls -R'
alias rm='rm -i'
alias df='df -h'
alias ps='ps -eF'
alias od='od -Ax -tx1z -v'
#alias od='od -Ax -tx1 -c -v'

# New command -------------------------------------------------------------
alias lessn='less -N'
alias capa='du -sh'
alias diffw='diff -w -y --suppress-common-lines'

function makearm {
 	make -j${CPUS} ARCH=arm SUBARCH=arm "$@"
}

function hgrep {
	history | egrep -i "$*" | tail;
}

function myTags {
	find ./ -name "*\.c" -or -name "*\.cpp" -or -name "*\.h" -or -name "*\.hpp" > myList
	ctags -L myList
	rm myList
}

function grep_scm {
	grep -I --exclude-dir='\.svn' --exclude-dir='\.git' $*
}

function setLang {
	case $1 in
	c)
		export LC_CTYPE=C
		export LC_ALL=C
		export LANG=C
		;;
	ja)
		export LC_CTYPE=ja_JP.UTF-8
		export LC_ALL=ja_JP.UTF-8
		export LANG=ja_JP.UTF-8
		;;
	#en)
	#	export LC_CTYPE=en_US.UTF-8
	#	export LC_ALL=en_US.UTF-8
	#	export LANG=en_US.UTF-8
	#	;;
	*)
		echo "usage: setLang {c,ja}"
		;;
	esac
}

function set_java {
	JAVA5_HOME=/opt/JAVA5
	JAVA6_HOME=/opt/JAVA6
	JAVA5_BIN=$JAVA5_HOME/bin
	JAVA6_BIN=$JAVA6_HOME/bin

	if [ -z $1 ]; then
		echo "Unknown version"
		return
	fi

	# unset java path
	export PATH=${PATH/:$JAVA5_BIN/}
	export PATH=${PATH/:$JAVA6_BIN/}
	export PATH=${PATH/$JAVA5_BIN:/}
	export PATH=${PATH/$JAVA6_BIN:/}
	# set java
	case $1 in
	5)
		echo "Set JAVA5"
		export JAVA_HOME=$JAVA5_HOME
		export PATH=$JAVA5_BIN:$PATH
		;;
	6)
		echo "Set JAVA6"
		export JAVA_HOME=$JAVA6_HOME
		export PATH=$JAVA6_BIN:$PATH
		;;
	esac
	# export some var
	export CLASSPATH=$JAVA_HOME/lib/tools.jar
	export ANDROID_JAVA_HOME=$JAVA_HOME
}

# Eclipse -----------------------------------------------------------------
set_java 6
export ANDROID_ECLIPSE_HOME=/opt/eclipse

if [ -n $ECLIPSE_HOME ]; then
	export PATH=${PATH/$ECLIPSE_HOME/}
fi
export ECLIPSE_HOME=/opt/eclipse
export PATH=$PATH:$ECLIPSE_HOME

# less --------------------------------------------------------------------
# Display line number and status for "less" command.
export LESS='-R -P ?f%f:(stdin).  ?lb%lb?L/%L..  [?eEOF:?pb%pb\%..]'
# Use vim as less
alias vless="/usr/share/vim/vim72/macros/less.sh"

# Subversion --------------------------------------------------------------
export SVN_EDITOR=vim

# Backup ------------------------------------------------------------------
function include_to_backup {
	INCLUDE_LIST=$HOME/backup/backup_include
	if [ -z $1 ]; then
		echo `pwd -P` >> $INCLUDE_LIST
	else
		echo `pwd -P`/$1 >> $INCLUDE_LIST
	fi
}

function exclude_from_backup {
	EXCLUDE_LIST=$HOME/backup/backup_exclude
	if [ -z $1 ]; then
		echo `pwd -P` >> $EXCLUDE_LIST
	else
		echo `pwd -P`/$1 >> $EXCLUDE_LIST
	fi
}

# IM settings -------------------------------------------------------------
#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=ibus
export PATH=$HOME/opt/bin:$PATH
alias vi='vim'
alias z='cd /cygdrive/z'

