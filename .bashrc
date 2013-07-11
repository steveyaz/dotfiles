# System-wide .bashrc file for interactive bash(1) shells.

# Enhanced Terminal Prompt
# Mac OS X 10.6 Version (Snow Leopard)
# Original from: http://phil.cryer.us/code/dotfiles/bashrc

# Example: 
# [14:42:52] [username@hostname ~/somedirectory]$ 

# In directories with a git repository, it will display the current branch in:
# - green: for a clean branch (HEAD and index clean)
# - orange: if the HEAD is clean but there are files to commit in the index
# - red: if there are modified files in the HEAD
# Original from: http://vvv.tobiassjosten.net/bash/dynamic-prompt-with-git-and-ansi-colors

# Example: 
# [14:42:52] [username@hostname ~/somedirectory] [master]$ 


# To be placed in /etc/bashrc or ~/.bashrc

##################################################
# Fancy PWD display function
##################################################
# The home directory (HOME) is replaced with a ~
# The last pwdmaxlen characters of the PWD are displayed
# Leading partial directory names are striped off
# /home/me/stuff          -> ~/stuff               if USER=me
# /usr/share/big_dir_name -> ../share/big_dir_name if pwdmaxlen=20
##################################################

bash_prompt_command() {
	# How many characters of the $PWD should be kept
	local pwdmaxlen=25
	# Indicate that there has been dir truncation
	local trunc_symbol=".."
	local dir=${PWD##*/}
	pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
	NEW_PWD=${PWD/$HOME/\~}
	local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
	if [ ${pwdoffset} -gt "0" ]
		then
		NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
		NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
	fi

	# Setup variable for current git branch, if available
	if ! git rev-parse --git-dir > /dev/null 2>&1; then
		GIT_CURRENT_BRANCH=""
		GIT_CURRENT_BRANCH_STATE_COLOR=""
	else
		if ! git diff --quiet 2>/dev/null >&2; then
			GIT_CURRENT_BRANCH_STATE_COLOR='\[\033[0;31m\]' #git dirty HEAD 
		else
			if ! git diff --cached --quiet 2>/dev/null >&2; then
				GIT_CURRENT_BRANCH_STATE_COLOR='\[\033[0;33m\]' #git dirty index
			else
				GIT_CURRENT_BRANCH_STATE_COLOR='\[\033[0;32m\]' #git clean branch
			fi
		fi
		GIT_CURRENT_BRANCH=" [$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')]"
	fi
	bash_prompt # call again this function to update PS1 to use corresponding GIT_CURRENT_BRANCH_STATE_COLOR
}

bash_prompt() {
	local NONE='\[\033[0m\]'    # unsets color to term's fg color

# NB: Unused Colors disabled

        # regular colors
#	local K='\[\033[0;30m\]'    # black
	local R='\[\033[0;31m\]'    # red
#	local G='\[\033[0;32m\]'    # green
#	local Y='\[\033[0;33m\]'    # yellow
	local B='\[\033[0;34m\]'    # blue
#	local M='\[\033[0;35m\]'    # magenta
#	local C='\[\033[0;36m\]'    # cyan
#	local W='\[\033[0;37m\]'    # white
						    
	# empahsized (bolded) colors
#	local EMK='\[\033[1;30m\]'
#	local EMR='\[\033[1;31m\]'
#	local EMG='\[\033[1;32m\]'
#	local EMY='\[\033[1;33m\]'
#	local EMB='\[\033[1;34m\]'
#	local EMM='\[\033[1;35m\]'
#	local EMC='\[\033[1;36m\]'
#	local EMW='\[\033[1;37m\]'
										        
	# background colors
#	local BGK='\[\033[40m\]'
#	local BGR='\[\033[41m\]'
#	local BGG='\[\033[42m\]'
#	local BGY='\[\033[43m\]'
#	local BGB='\[\033[44m\]'
#	local BGM='\[\033[45m\]'
#	local BGC='\[\033[46m\]'
#	local BGW='\[\033[47m\]'
															    
	local UC=$C                 # user's color
        [ $UID -eq "0" ] && UC=$R   # root's color
	
	#PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
	#PS1="${EMK}[${UC}\u${EMR}@${UC}\h ${EMB}\${NEW_PWD}${EMK}]${UC}\\$ ${NONE}"

	PS1="${NONE}[\t${NONE}] ${NONE}[${R}\u${R}@${R}\h ${B}\${NEW_PWD}${NONE}]${G}${GIT_CURRENT_BRANCH_STATE_COLOR}\${GIT_CURRENT_BRANCH}${NONE}\\$ ${NONE}"
	SUDO_PS1="${NONE}[\t${NONE}] ${NONE}[${R}\u${R}@${R}\h ${B}\${NEW_PWD}${NONE}]${G}\${GIT_CURRENT_BRANCH}${NONE}\\$ ${NONE}"
}
	
PROMPT_COMMAND=bash_prompt_command 
bash_prompt
#unset bash_prompt # Don't unset this function if updating the PS1 variable every time

#ORIGINAL BASHRC PS1 DEFINITION:
#if [ -z "$PS1" ]; then
#   return
#fi
#
#PS1='\h:\W \u\$ '

# Make bash check its window size after a process completes
shopt -s checkwinsize
