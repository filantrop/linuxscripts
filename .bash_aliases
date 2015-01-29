# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
   #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Custom Aliases
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias cd..="cd .."
alias cd...="cd ../.."
alias cd....="cd ../../.."
alias cd.....="cd ../../../.."
alias cd......="cd ../../../../.."

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ll="ls -l --group-directories-first --color=auto"
  alias ls='ls -hF --color=auto'   # add colors for filetype recognition
  alias la='ls -Al --color=auto'   # show hidden files
  alias lx='ls -lXB --color=auto'  # sort by extension
  alias lk='ls -lSr --color=auto'  # sort by size, biggest last
  alias lc='ls -ltcr --color=auto' # sort by and show change time, most recent last
  alias lu='ls -ltur --color=auto' # sort by and show access time, most recent last
  alias lt='ls -ltr --color=auto'  # sort by date, most recent last
  alias lr='ls -lR --color=auto'   # recursive ls
  alias dir='dir --color=auto'     # add colors
  alias vdir='vdir --color=auto'   # add colors
  alias grep='grep --color=auto'   # add colors
  alias fgrep='fgrep --color=auto' # add colors
  alias egrep='egrep --color=auto' # add colors
else
  alias ll="ls -l --group-directories-first"
  alias ls='ls -hF'   # filetype recognition
  alias la='ls -Altr'   # sort by date, most recent last, show hidden files
  alias lx='ls -lXB'  # sort by extension
  alias lk='ls -lSr'  # sort by size, biggest last
  alias lc='ls -ltcr' # sort by and show change time, most recent last
  alias lu='ls -ltur' # sort by and show access time, most recent last
  alias lt='ls -ltr'  # sort by date, most recent last
  alias lr='ls -lR'   # recursive ls
fi

alias df='df -kTh'
alias wget='wget --no-check-certificate'


# Add functions
function stitle()
{
   if [ $# -gt 0 ] ;then
     echo -e "\033k$*\033\\"
   fi
}
function pt()
{
    stitle $(whoami)@$(hostname) $(pwd)
}

